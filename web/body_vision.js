// ThreadSense web vision bridge: real pixel-contour body measurement.
//
// HONEST BY DESIGN — this bridge never fabricates:
// - It starts with NO person detected. A person is only reported when
//   strong body/background edges are actually found in the <video> frame.
// - Confidence reflects measured edge strength + temporal stability.
//   It is never driven by a timer.
// - Centimeter values are calibrated from the user's real height:
//       cmPerPixel = userHeightCm / pixelStature (head-to-foot in frame).
//   The height is pushed from Dart via setThreadSenseUserHeightCm().
//   Without a valid stature or height, NO cm values are emitted —
//   the Dart side treats missing cm as invalid data, not as a guess.
// - This is a best-effort contour estimate for garment fitting, not a
//   precise measurement. Single-camera edge detection cannot see true
//   body contours through loose clothing or cluttered backgrounds.

(function () {
  'use strict';

  // Calibrated by Dart (scan preparation screen requires height entry).
  let userHeightCm = 0;
  function setUserHeightCm(cm) {
    const v = Number(cm);
    userHeightCm = Number.isFinite(v) && v > 0 ? v : 0;
  }
  window.setThreadSenseUserHeightCm = setUserHeightCm;
  if (typeof globalThis !== 'undefined') {
    globalThis.setThreadSenseUserHeightCm = setUserHeightCm;
  }

  const PROC_W = 120;
  const PROC_H = 160;
  const GRAD_THRESHOLD = 28; // luminance edge strength that counts as a body edge
  const MIN_ROWS_FOR_PERSON = 3; // of the 4 anatomical rows below

  let offscreenCanvas = null;
  let offscreenCtx = null;
  let lastFrameTime = 0;

  // Temporal state
  let smoothGeo = null; // last good {shoulder,chest,waist,hips} -> {left,right}
  let lastCenterX = 0.5;
  let lastChestWidth = 0;
  let stableFrames = 0;

  // No person until vision proves otherwise.
  let currentVisionState = {
    hasPerson: false,
    hasFullBody: false,
    isTooClose: false,
    isCutOffTop: false,
    isCutOffBottom: false,
    confidence: 0,
    statusMessage: 'POSITION YOURSELF IN FRAME',
    landmarks: null,
  };

  function findVideoElement() {
    return document.querySelector('video');
  }

  function luminanceAt(data, x, y) {
    const i = (y * PROC_W + x) * 4;
    return 0.299 * data[i] + 0.587 * data[i + 1] + 0.114 * data[i + 2];
  }

  // Scans one horizontal row outward from the frame center and returns the
  // first strong body/background edge on each side. found=false when no
  // real edge exists (e.g. empty background) — never a guessed default.
  function scanRow(data, targetY) {
    const y = Math.max(1, Math.min(PROC_H - 2, Math.round(targetY * PROC_H)));
    const midX = Math.round(PROC_W / 2);
    let leftX = -1;
    let rightX = -1;
    let maxGrad = 0;

    for (let x = midX; x >= 2; x--) {
      const g = Math.abs(luminanceAt(data, x, y) - luminanceAt(data, x - 1, y));
      if (g > maxGrad) maxGrad = g;
      if (g > GRAD_THRESHOLD) {
        leftX = x;
        break;
      }
    }
    for (let x = midX; x < PROC_W - 2; x++) {
      const g = Math.abs(luminanceAt(data, x, y) - luminanceAt(data, x + 1, y));
      if (g > maxGrad) maxGrad = g;
      if (g > GRAD_THRESHOLD) {
        rightX = x;
        break;
      }
    }
    const found = leftX > 0 && rightX > 0 && rightX > leftX;
    const width = found ? (rightX - leftX) / PROC_W : 0;
    return {
      found: found,
      left: leftX / PROC_W,
      right: rightX / PROC_W,
      width: width,
      strength: Math.min(1, maxGrad / (GRAD_THRESHOLD * 3)),
    };
  }

  // Vertical scan at the torso center for head (top-down) and feet
  // (bottom-up), giving pixel stature for height calibration.
  function scanStature(data, centerXRatio) {
    const x =
      Math.max(1, Math.min(PROC_W - 2, Math.round(centerXRatio * PROC_W)));
    let headY = -1;
    let feetY = -1;
    for (let y = 2; y < PROC_H - 2; y++) {
      const g = Math.abs(luminanceAt(data, x, y) - luminanceAt(data, x, y - 1));
      if (g > GRAD_THRESHOLD) {
        headY = y;
        break;
      }
    }
    for (let y = PROC_H - 3; y >= 2; y--) {
      const g = Math.abs(luminanceAt(data, x, y) - luminanceAt(data, x, y + 1));
      if (g > GRAD_THRESHOLD) {
        feetY = y;
        break;
      }
    }
    return { headY: headY, feetY: feetY };
  }

  function analyzeVideoFrame() {
    requestAnimationFrame(analyzeVideoFrame);

    const now = performance.now();
    if (now - lastFrameTime < 120) return; // ~8 fps is plenty for contours
    lastFrameTime = now;

    const video = findVideoElement();
    if (
      !video ||
      video.readyState < 2 ||
      video.videoWidth === 0 ||
      video.videoHeight === 0
    ) {
      return;
    }

    if (!offscreenCanvas) {
      offscreenCanvas = document.createElement('canvas');
      offscreenCanvas.width = PROC_W;
      offscreenCanvas.height = PROC_H;
      offscreenCtx = offscreenCanvas.getContext('2d', {
        willReadFrequently: true,
      });
    }

    try {
      offscreenCtx.drawImage(video, 0, 0, PROC_W, PROC_H);
      const data = offscreenCtx.getImageData(0, 0, PROC_W, PROC_H).data;

      const rows = [
        scanRow(data, 0.22), // shoulders
        scanRow(data, 0.36), // chest
        scanRow(data, 0.5), // waist
        scanRow(data, 0.64), // hips
      ];

      // Only human-plausible widths count: a "detection" spanning the whole
      // frame or a sliver is background texture, not a person.
      const validRows = rows.filter(
        (r) => r.found && r.width > 0.12 && r.width < 0.8
      );
      const personDetected = validRows.length >= MIN_ROWS_FOR_PERSON;

      if (!personDetected) {
        stableFrames = 0;
        smoothGeo = null;
        currentVisionState = {
          hasPerson: false,
          hasFullBody: false,
          isTooClose: false,
          isCutOffTop: false,
          isCutOffBottom: false,
          confidence: 0,
          statusMessage: 'NO PERSON DETECTED — STEP INTO FRAME',
          landmarks: null,
        };
        return;
      }

      const centerX = (rows[1].left + rows[1].right) / 2;
      const chestWidth = rows[1].width;

      const stature = scanStature(data, centerX);
      const cutOffTop = stature.headY < 0;
      const cutOffBottom = stature.feetY < 0;
      const staturePx =
        !cutOffTop && !cutOffBottom ? stature.feetY - stature.headY : 0;
      const hasFullBody = staturePx > PROC_H * 0.5;

      // Height calibration: real cm-per-pixel from the user's own height.
      // No height or no measurable stature => no cm values, period.
      const cmPerPx =
        userHeightCm > 0 && staturePx > 0 ? userHeightCm / staturePx : 0;

      // Temporal stability from actual frame-to-frame deltas.
      const centerDelta = Math.abs(centerX - lastCenterX);
      const widthDelta = Math.abs(chestWidth - lastChestWidth);
      if (centerDelta < 0.03 && widthDelta < 0.03) {
        stableFrames = Math.min(60, stableFrames + 1);
      } else {
        stableFrames = Math.max(0, stableFrames - 2);
      }
      lastCenterX = centerX;
      lastChestWidth = chestWidth;

      // EMA smoothing per row; a row with no edge this frame holds its
      // last good contour instead of inventing one.
      const alpha = 0.35;
      const names = ['shoulder', 'chest', 'waist', 'hips'];
      const geo = {};
      names.forEach((name, i) => {
        const r = rows[i];
        const prev = smoothGeo ? smoothGeo[name] : null;
        if (r.found) {
          geo[name] = {
            left: prev ? prev.left * (1 - alpha) + r.left * alpha : r.left,
            right:
              prev ? prev.right * (1 - alpha) + r.right * alpha : r.right,
          };
        } else if (prev) {
          geo[name] = prev;
        } else {
          geo[name] = null;
        }
      });
      smoothGeo = geo;
      const complete = names.every((n) => geo[n] !== null);

      // Confidence from measured signal only: edge strength + stability.
      // It never climbs on a timer — move and it drops.
      const rowScore =
        validRows.reduce((acc, r) => acc + r.strength, 0) / 4;
      const stabilityScore = Math.min(1, stableFrames / 20);
      const confidence = Math.max(
        0,
        Math.min(1, 0.2 + 0.55 * rowScore + 0.25 * stabilityScore)
      );

      const tooClose = rows[1].width > 0.75 || rows[0].width > 0.75;
      let statusMessage;
      if (tooClose) {
        statusMessage = 'TOO CLOSE — STEP BACK';
      } else if (cutOffTop || cutOffBottom || !hasFullBody) {
        statusMessage = 'MOVE TO FIT YOUR FULL BODY IN FRAME';
      } else if (confidence < 0.6) {
        statusMessage = 'HOLD STEADY — READING CONTOURS';
      } else {
        statusMessage = 'HOLD STEADY — MEASURING';
      }

      function widthCm(name) {
        const g = geo[name];
        if (!g || cmPerPx <= 0) return null;
        return Math.round((g.right - g.left) * PROC_W * cmPerPx * 10) / 10;
      }

      currentVisionState = {
        hasPerson: true,
        hasFullBody: hasFullBody,
        isTooClose: tooClose,
        isCutOffTop: cutOffTop,
        isCutOffBottom: cutOffBottom,
        confidence: Math.round(confidence * 100) / 100,
        statusMessage: statusMessage,
        landmarks: complete
          ? {
              shoulder: {
                y: 0.22,
                leftX: geo.shoulder.left,
                rightX: geo.shoulder.right,
                cm: widthCm('shoulder'),
              },
              chest: {
                y: 0.36,
                leftX: geo.chest.left,
                rightX: geo.chest.right,
                cm: widthCm('chest'),
              },
              waist: {
                y: 0.5,
                leftX: geo.waist.left,
                rightX: geo.waist.right,
                cm: widthCm('waist'),
              },
              hips: {
                y: 0.64,
                leftX: geo.hips.left,
                rightX: geo.hips.right,
                cm: widthCm('hips'),
              },
              headY: cutOffTop ? null : stature.headY / PROC_H,
              feetY: cutOffBottom ? null : stature.feetY / PROC_H,
              centerX: centerX,
              bodyWidth: chestWidth,
            }
          : null,
      };
    } catch (e) {
      console.warn('[ThreadSense Vision] Frame error:', e);
    }
  }

  requestAnimationFrame(analyzeVideoFrame);

  function getVisionJson() {
    return JSON.stringify(currentVisionState);
  }
  window.getThreadSenseVisionJson = getVisionJson;
  if (typeof globalThis !== 'undefined') {
    globalThis.getThreadSenseVisionJson = getVisionJson;
  }

  console.log('[ThreadSense Vision] Contour engine ready (no canned data).');
})();

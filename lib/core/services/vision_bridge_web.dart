import 'dart:js_interop';

@JS('getThreadSenseVisionJson')
external JSString? _jsGetVisionJson();

@JS('setThreadSenseUserHeightCm')
external void _jsSetUserHeightCm(JSNumber cm);

String? getLiveVisionJson() {
  try {
    final result = _jsGetVisionJson();
    return result?.toDart;
  } catch (e) {
    return null;
  }
}

/// Pushes the user's height (cm) into the JS contour engine so pixel
/// widths can be calibrated to real centimeters. Safe to call before the
/// JS bridge has loaded — the call is ignored until it exists.
void setWebVisionHeightCm(double cm) {
  try {
    _jsSetUserHeightCm(cm.toJS);
  } catch (_) {}
}

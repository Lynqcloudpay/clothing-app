import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/body_measurements.dart';
import '../models/body_scan_session.dart';

class ScanNotifier extends StateNotifier<BodyScanSession> {
  ScanNotifier()
      : super(BodyScanSession(
          id: 'session_1',
          userId: 'user_1',
          startedAt: DateTime.now(),
        ));

  void updateStatus(ScanStatus newStatus) {
    state = state.copyWith(status: newStatus);
  }

  void updateProgress(double progress) {
    state = state.copyWith(scanProgress: progress);
  }

  void setMeasurements(BodyMeasurements measurements) {
    state = state.copyWith(measurements: measurements);
  }
}

final scanSessionProvider =
    StateNotifierProvider<ScanNotifier, BodyScanSession>((ref) {
  return ScanNotifier();
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/scan_provider.dart';
import '../../../core/models/body_scan_session.dart';
import '../../../core/services/body_measurement_engine.dart';

class ScanController {
  final WidgetRef ref;
  bool _isDisposed = false;
  
  ScanController(this.ref);

  void initialize() {
    ref.read(scanSessionProvider.notifier).updateStatus(ScanStatus.preparing);
    _simulateScanFlow();
  }

  Future<void> _simulateScanFlow() async {
    final notifier = ref.read(scanSessionProvider.notifier);
    
    await Future.delayed(const Duration(milliseconds: 1500));
    if (_isDisposed) return;
    notifier.updateStatus(ScanStatus.scanning);
    
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      if (_isDisposed) return;
      notifier.updateProgress(i / 10.0);
    }
    
    if (_isDisposed) return;
    notifier.updateStatus(ScanStatus.processing);
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (_isDisposed) return;
    final measurements = BodyMeasurementEngine.computeMeasurements();
    notifier.setMeasurements(measurements);
    notifier.updateStatus(ScanStatus.completed);
  }

  void dispose() {
    _isDisposed = true;
  }
}

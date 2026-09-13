import 'package:flutter/services.dart';

class HapticFeedbackUtil {
  static void success() {
    HapticFeedback.lightImpact();
  }
}

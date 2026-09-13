import 'dart:js_interop';

@JS('getThreadSenseVisionJson')
external JSString? _jsGetVisionJson();

String? getLiveVisionJson() {
  try {
    final result = _jsGetVisionJson();
    return result?.toDart;
  } catch (e) {
    return null;
  }
}

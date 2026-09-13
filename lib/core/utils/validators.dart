class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    return null;
  }
}

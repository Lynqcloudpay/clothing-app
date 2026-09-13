import 'package:flutter_test/flutter_test.dart';
import 'package:threadsense/core/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    test('should parse from JSON correctly', () {
      final json = {
        'id': 'user123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'createdAt': '2026-09-11T12:00:00.000Z',
        'preferences': {
          'units': 'cm',
        },
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 'user123');
      expect(user.email, 'test@example.com');
      expect(user.preferences.units, 'cm');
    });
  });
}

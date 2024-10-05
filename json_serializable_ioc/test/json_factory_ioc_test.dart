import 'package:json_serializable_ioc/json_serializable_ioc.dart';
import 'package:test/test.dart';

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}

void main() {
  group('A group of tests for JsonFactoryIoc', () {
    setUp(() {
      JsonFactoryIoc().registerFactory<User>(
        (json) => User.fromJson(json),
      );
    });

    test('Test JsonFactoryIoc for User model', () {
      final int userId = 55;
      final String userName = 'Test User';
      User user = factory<User>({
        'id': userId,
        'name': userName,
      });

      expect(user.id, userId);
      expect(user.name, userName);
    });
  });
}

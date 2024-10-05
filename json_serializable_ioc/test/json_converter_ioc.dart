import 'package:json_serializable_ioc/json_serializable_ioc.dart';
import 'package:test/test.dart';

class User {
  final int id;
  final String name;

  User({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

void main() {
  group('A group of tests for JsonConverterIoc', () {
    setUp(() {
      JsonConverterIoc().registerConverter<User>(
        (model) => model.toJson(),
      );
    });

    test('Test JsonConverterIoc for User model', () {
      final int userId = 55;
      final String userName = 'Test User';
      User user = User(id: userId, name: userName);
      Map<String, dynamic> userJson = converter<User>(user);

      expect(userJson['id'], userId);
      expect(userJson['name'], userName);
    });
  });
}

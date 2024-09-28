import 'package:json_converter_ioc/json_converter_ioc.dart';
import 'package:test/test.dart';

class User extends JsonToMap {
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

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}

void main() {
  group('A group of tests for JsonConverterIoc', () {
    setUp(() {
      JsonConverterIoc().registerConverter<User>(
        (model) => model.toMap(),
      );
    });

    test('Test JsonConverterIoc for User model', () {
      final int userId = 55;
      final String userName = 'Test User';
      User user = User(id: userId, name: userName);

      Map<String, dynamic> userMap = converter(user);

      expect(userMap['id'], user.id);
      expect(userMap['name'], user.name);
    });
  });
}

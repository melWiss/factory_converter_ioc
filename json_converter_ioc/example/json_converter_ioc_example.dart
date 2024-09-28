import 'package:json_converter_ioc/json_converter_ioc.dart';

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
  JsonConverterIoc().registerConverter<User>(
    (model) => model.toMap(),
  );
  final int userId = 55;
  final String userName = 'Test User';
  User user = User(id: userId, name: userName);

  Map<String, dynamic> userMap = converter(user);

  print("userMap['id'] = user.id  => ${userMap['id'] == user.id}");
  print("userMap['name'] = user.name  => ${userMap['name'] == user.name}");
}

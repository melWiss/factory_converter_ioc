import 'package:json_serializable_ioc/json_serializable_ioc.dart';

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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

void main() {
  // register the factory inside the ioc
  JsonFactoryIoc().registerFactory<User>(
    (json) => User.fromJson(json),
  );

  JsonConverterIoc().registerConverter<User>(
    (model) => model.toJson(),
  );
  final int userId = 55;
  final String userName = 'Test User';
  // call the factory using the [factory<T>] method.
  User user = factory({
    'id': userId,
    'name': userName,
  });

  print('user.id: ${user.id} = $userId');
  print('user.name: ${user.name} = $userName');

  // call the converter using [converter<T>] method.
  Map<String, dynamic> map = converter<User>(user);

  print('user.id: ${map['id']} = $userId');
  print('user.name: ${map['name']} = $userName');

}

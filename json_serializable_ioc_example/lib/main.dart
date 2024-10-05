import 'dart:convert';

import 'package:json_ioc_example/user.dart';
import 'package:json_ioc_example/main.json_ioc.dart';
import 'package:json_serializable_ioc/json_serializable_ioc.dart';

@RegisterJsonSerializable()
void main(List<String> arguments) {
  $registerJsonSerializableMethods();
  User user = factory<User>({
    "id": 55,
    "name": "potatoes",
  });

  print(jsonEncode(converter<User>(user)));
}

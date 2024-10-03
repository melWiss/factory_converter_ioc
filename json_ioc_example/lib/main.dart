import 'dart:convert';

import 'package:json_converter_ioc/json_converter_ioc.dart';
import 'package:json_factory_converter_ioc_annotations/json_factory_converter_ioc_annotations.dart';
import 'package:json_factory_ioc/json_factory_ioc.dart';
import 'package:json_ioc_example/user.dart';
import 'package:json_ioc_example/main.json_ioc.dart';

@RegisterFactoriesAndConverters()
void main(List<String> arguments) {
  $registerJsonSerializableMethods();
  User user = factory<User>({
    "id": 55,
    "name": "potatoes",
  });

  print(jsonEncode(converter<User>(user)));
}

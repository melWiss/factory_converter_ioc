// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonIocGenerator
// **************************************************************************

import 'package:json_factory_ioc/json_factory_ioc.dart';
import 'package:json_converter_ioc/json_converter_ioc.dart';
import 'package:json_ioc_example/user.dart';

void $registerJsonSerializableMethods() {
  JsonFactoryIoc().registerFactory<User>(
    (json) => User.fromJson(json),
  );
  JsonConverterIoc().registerConverter<User>(
    (model) => model.toJson(),
  );
}

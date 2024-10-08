// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonIocGenerator
// **************************************************************************

import 'package:json_serializable_ioc/json_serializable_ioc.dart';
import 'package:json_ioc_example/user.dart';

void $registerJsonSerializableMethods() {
  JsonFactoryIoc().registerFactory<User>(
    (json) => User.fromJson(json),
  );
  JsonConverterIoc().registerConverter<User>(
    (model) => model.toJson(),
  );
  JsonFactoryIoc().registerFactory<Profile>(
    (json) => Profile.fromJson(json),
  );
  JsonConverterIoc().registerConverter<Profile>(
    (model) => model.toJson(),
  );
}

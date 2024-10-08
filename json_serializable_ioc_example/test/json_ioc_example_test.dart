import 'dart:convert';

import 'package:json_ioc_example/user.dart';
import 'package:test/test.dart';
import 'package:json_ioc_example/main.json_ioc.dart';
import 'package:json_serializable_ioc/json_serializable_ioc.dart';

@RegisterJsonSerializable()
void main() {
  $registerJsonSerializableMethods();
  group(
    'Test JsonSerializableIocGenerator',
    () {
      test(
        'Test factory<T> and converter<T>',
        () {
          Map<String, dynamic> userMap = {
            "id": 55,
            "name": "potatoes",
          };
          User user = factory<User>(userMap);
          Profile profile = factory<Profile>(userMap);

          expect(jsonEncode(userMap), jsonEncode(converter<User>(user)));
          expect(jsonEncode(userMap), jsonEncode(converter<Profile>(profile)));
        },
      );
    },
  );
}

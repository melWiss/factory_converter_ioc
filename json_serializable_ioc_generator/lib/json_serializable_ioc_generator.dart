import 'package:build/build.dart';
import 'package:json_serializable_ioc_generator/src/json_ioc_generator.dart';
import 'package:json_serializable_ioc_generator/src/json_serializable_registrar.dart';
import 'package:source_gen/source_gen.dart';


Builder configureJsonSerializableRegistrar(BuilderOptions options) {
  return LibraryBuilder(
    JsonSerializableRegistrar(),
    generatedExtension: '.serializable.json',
    header: '',
    formatOutput: (code) {
      var lines =  code.split('\n');
      lines.removeRange(0, 4);
      return lines.join();
    },
  );
}


Builder registerJsonSerializableIoc(BuilderOptions options) {
  return LibraryBuilder(
    JsonIocGenerator(),
    generatedExtension: '.json_ioc.dart',
  );
}
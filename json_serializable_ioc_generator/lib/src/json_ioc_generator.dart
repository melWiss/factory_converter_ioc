import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:json_serializable_ioc/json_serializable_ioc.dart';
import 'package:json_serializable_ioc_generator/src/json_serializable_registrar_model.dart';
import 'package:source_gen/source_gen.dart';

class JsonIocGenerator
    extends GeneratorForAnnotation<RegisterJsonSerializable> {
  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    log.info('Starting [JsonIocGenerator]⌛');
    StringBuffer buffer = StringBuffer();
    // step 1: prepare files
    final factoryFilesGlob = Glob('**/*.serializable.json');
    final factoryFiles = factoryFilesGlob.listSync();
    if (factoryFiles.isNotEmpty) {
      buffer.writeln(
          "import 'package:json_serializable_ioc/json_serializable_ioc.dart';");
    }

    // step 2: add imports
    for (var file in factoryFiles) {
      String filePath = file.path;
      filePath = filePath
          .replaceAll('\\', '/')
          .replaceAll('./.dart_tool/build/generated/', '')
          .replaceAll('/lib', '')
          .replaceAll('.serializable.json', '.dart');
      buffer.writeln("import 'package:$filePath';");
    }

    // step 3: declare methods
    if (factoryFiles.isNotEmpty) {
      buffer.writeln("void \$registerJsonSerializableMethods() {");
      for (var element in factoryFiles) {
        File file = File(element.path);
        String fileContent = file.readAsStringSync();
        fileContent = '[${fileContent.replaceAll('}{', '},{')}]';
        List data = jsonDecode(fileContent);
        for (var json in data) {
          JsonSerializableRegistrarModel model =
              JsonSerializableRegistrarModel.fromMap(json);
          if (model.factoryName != null) {
            buffer
                .writeln("JsonFactoryIoc().registerFactory<${model.className}>("
                    "(json) => ${model.factoryName}(json),"
                    ");");
          }
          if (model.converterName != null) {
            buffer.writeln(
                "JsonConverterIoc().registerConverter<${model.className}>("
                "(model) => model.${model.converterName}(),"
                ");");
          }
        }
      }
      buffer.writeln("}");
    }
    log.info('[JsonIocGenerator] is finished✅');
    return buffer.toString();
  }
}

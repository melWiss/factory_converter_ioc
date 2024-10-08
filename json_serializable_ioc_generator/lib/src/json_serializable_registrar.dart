import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable_ioc_generator/src/json_serializable_registrar_model.dart';
import 'package:json_serializable_ioc_generator/src/json_serializable_visitor.dart';
import 'package:source_gen/source_gen.dart';

class JsonSerializableRegistrar
    extends GeneratorForAnnotation<JsonSerializable> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is ClassElement) {
      JsonSerializableVisitor visitor = JsonSerializableVisitor();
      visitor.visitClassElement(element);
      log.info('Preparing ${visitor.className}Registrar⌛');
      JsonSerializableRegistrarModel model = JsonSerializableRegistrarModel(
        className: visitor.className!,
        classPath: buildStep.inputId.path,
        factoryName: visitor.factoryName,
        converterName: visitor.converterName,
      );
      log.info('Done preparing ${visitor.className}Registrar✅');
      return model.toJson();
    }
    return '{}';
  }
}

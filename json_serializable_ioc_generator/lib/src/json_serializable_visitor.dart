import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';

class JsonSerializableVisitor extends SimpleElementVisitor<void> {
  String? className;
  String? factoryName;
  String? converterName;

  @override
  void visitClassElement(ClassElement element) {
    // find the class name
    className = element.displayName;

    // find the factory constructor
    var factoryConstructors = element.constructors.where((element) {
      return element.parameters.length == 1 &&
          element.parameters.any(
            (element) =>
                element.type.getDisplayString(withNullability: true) ==
                'Map<String, dynamic>',
          );
    });

    if (factoryConstructors.isNotEmpty) {
      factoryName = factoryConstructors.first.displayName;
    }

    // find the converter method
    var converterMethods = element.methods.where(
      (element) {
        return element.parameters.isEmpty &&
            element.returnType.getDisplayString(withNullability: true) ==
                'Map<String, dynamic>';
      },
    );

    if (converterMethods.isNotEmpty) {
      converterName = converterMethods.first.displayName;
    }
  }
}

import 'dart:convert';

class JsonSerializableRegistrarModel {
  final String className;
  final String classPath;
  final String? converterName;
  final String? factoryName;
  JsonSerializableRegistrarModel({
    required this.className,
    required this.classPath,
    this.converterName,
    this.factoryName,
  });

  JsonSerializableRegistrarModel copyWith({
    String? className,
    String? classPath,
    String? converterName,
    String? factoryName,
  }) {
    return JsonSerializableRegistrarModel(
      className: className ?? this.className,
      classPath: classPath ?? this.classPath,
      converterName: converterName ?? this.converterName,
      factoryName: factoryName ?? this.factoryName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'className': className,
      'classPath': classPath,
      'converterName': converterName,
      'factoryName': factoryName,
    };
  }

  factory JsonSerializableRegistrarModel.fromMap(Map<String, dynamic> map) {
    return JsonSerializableRegistrarModel(
      className: map['className'] ?? '',
      classPath: map['classPath'] ?? '',
      converterName: map['converterName'],
      factoryName: map['factoryName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JsonSerializableRegistrarModel.fromJson(String source) =>
      JsonSerializableRegistrarModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JsonSerializableRegistrarModel(className: $className, classPath: $classPath, converterName: $converterName, factoryName: $factoryName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JsonSerializableRegistrarModel &&
        other.className == className &&
        other.classPath == classPath &&
        other.converterName == converterName &&
        other.factoryName == factoryName;
  }

  @override
  int get hashCode {
    return className.hashCode ^
        classPath.hashCode ^
        converterName.hashCode ^
        factoryName.hashCode;
  }
}

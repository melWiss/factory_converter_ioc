typedef JsonConverterFunction<T> = Map<String, dynamic> Function(T model);

Exception jsonConverterNotFoundException<T>() =>
    Exception('Converter for $T isn\'t registered');

class JsonConverterIoc {
  static JsonConverterIoc? _instance;
  JsonConverterIoc._();

  /// the singleton constructor.
  factory JsonConverterIoc() {
    return _instance ??= JsonConverterIoc._();
  }

  /// the converter registry.
  final Map<Type, Map<String, dynamic> Function(dynamic model)> _registry = {};

  /// register a converter method using the type T.
  void registerConverter<T>(JsonConverterFunction converter) {
    _registry[T] = converter;
  }

  /// remove the converter using it's type T.
  void removeConverter<T>() {
    if (_registry.containsKey(T)) {
      _registry.remove(T);
    } else {
      throw jsonConverterNotFoundException();
    }
  }

  /// get the converter using it's type T.
  JsonConverterFunction<T> getConverter<T>() {
    if (_registry.containsKey(T)) {
      return _registry[T] as JsonConverterFunction<T>;
    }
    throw jsonConverterNotFoundException();
  }
}

Map<String, dynamic> converter<T>(T model) =>
    JsonConverterIoc().getConverter<T>()(model);

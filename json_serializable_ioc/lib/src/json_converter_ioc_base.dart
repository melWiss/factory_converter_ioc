typedef JsonConverterFunction<T> = Map<String, dynamic> Function(T model);

/// it's an exception that happens when a converter that you're looking for
/// doesn't exist.
Exception _jsonConverterNotFoundException<T>() =>
    Exception('Converter for $T isn\'t registered');

/// the container that has the converters model's "toMap" methods.
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
      throw _jsonConverterNotFoundException();
    }
  }

  /// get the converter using it's type T.
  JsonConverterFunction<T> getConverter<T>() {
    if (_registry.containsKey(T)) {
      return _registry[T] as JsonConverterFunction<T>;
    }
    throw _jsonConverterNotFoundException();
  }
}

/// a quick access to the converter container by providing the type and the model
/// instance that you want to convert.
Map<String, dynamic> converter<T>(T model) =>
    JsonConverterIoc().getConverter<T>()(model);

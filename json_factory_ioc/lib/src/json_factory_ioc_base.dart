typedef JsonFactoryFunction<T> = T Function(Map<String, dynamic> json);

Exception jsonFactoryNotFoundException<T>() =>
    Exception('Factory for $T isn\'t registered');

class JsonFactoryIoc {
  static JsonFactoryIoc? _instance;
  JsonFactoryIoc._();

  /// the singleton constructor.
  factory JsonFactoryIoc() {
    return _instance ??= JsonFactoryIoc._();
  }

  /// the factory registry.
  final Map<Type, Function(Map<String, dynamic> json)> _registry = {};

  /// register a factory method using the type T.
  void registerFactory<T>(JsonFactoryFunction factory) {
    _registry[T] = factory;
  }

  /// remove the factory using it's type T.
  void removeFactory<T>() {
    if (_registry.containsKey(T)) {
      _registry.remove(T);
    } else {
      throw jsonFactoryNotFoundException();
    }
  }

  /// get the factory using it's type T.
  JsonFactoryFunction<T> getFactory<T>() {
    if (_registry.containsKey(T)) {
      return _registry[T] as JsonFactoryFunction<T>;
    }
    throw jsonFactoryNotFoundException();
  }
}

T factory<T>(Map<String, dynamic> json) =>
    JsonFactoryIoc().getFactory<T>()(json);

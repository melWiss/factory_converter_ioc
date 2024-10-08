## json_serializable_ioc

`json_serializable_ioc` simplifies the serialization and deserialization of models by encapsulating `toJson` and `fromJson` methods in a container. It allows developers to register converters and factories for any model, enabling the dynamic use of these methods without knowing their exact names.

### Features
- **Dynamic Serialization**: Access `toJson` and `fromJson` methods based on type.
- **Registry Management**: Easily register, retrieve, and remove converters and factories for models.
- **Error Handling**: Provides custom exceptions when a converter or factory is not found.

---

### Installation

To include `json_serializable_ioc` in your Dart or Flutter project, add the following to your `pubspec.yaml`:

```yaml
dependencies:
  json_serializable_ioc: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

### Basic Usage

#### 1. Define your model with `toJson` and `fromJson` methods:

```dart
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}
```

#### 2. Register and use the `JsonFactoryIoc` container for deserialization:

```dart
void main() {
  // Register the User factory in the container
  JsonFactoryIoc().registerFactory<User>((json) => User.fromJson(json));

  // Create a User object from JSON
  final user = factory<User>({'id': 55, 'name': 'John Doe'});

  print(user.name); // Output: John Doe
  print(user.id);   // Output: 55
}
```

In this example, the `User` model’s `fromJson` method is registered in the `JsonFactoryIoc` container. You can then use the `factory<T>` function to dynamically convert JSON data into an instance of `User` without manually calling the `fromJson` method.

#### 3. Register and use the `JsonConverterIoc` container for serialization:

```dart
void main() {
  // Register the User converter in the container
  JsonConverterIoc().registerConverter<User>((user) => user.toJson());

  // Convert a User object to JSON
  final user = User(id: 55, name: 'John Doe');
  final userJson = converter<User>(user);

  print(userJson); // Output: {id: 55, name: John Doe}
}
```

Here, the `toJson` method of the `User` model is registered in the `JsonConverterIoc` container. You can then use the `converter<T>` function to serialize a `User` instance to a JSON map without manually calling the `toJson` method.

---

### API Reference

#### JsonFactoryIoc

The `JsonFactoryIoc` class manages model deserialization (`fromJson`) through registered factory functions.

- **registerFactory<T>(JsonFactoryFunction<T>)**: Registers a factory method for a specific type `T`.
- **removeFactory<T>()**: Removes the factory method for the type `T`. Throws an exception if the factory is not found.
- **getFactory<T>()**: Retrieves the factory method for type `T`. Throws an exception if not registered.
- **factory<T>(Map<String, dynamic> json)**: Creates an instance of `T` using the registered factory.

#### JsonConverterIoc

The `JsonConverterIoc` class manages model serialization (`toJson`) through registered converter functions.

- **registerConverter<T>(JsonConverterFunction<T>)**: Registers a converter method for type `T`.
- **removeConverter<T>()**: Removes the converter method for type `T`. Throws an exception if not found.
- **getConverter<T>()**: Retrieves the converter method for type `T`. Throws an exception if not registered.
- **converter<T>(T model)**: Converts an instance of `T` to a `Map<String, dynamic>` using the registered converter.

---

### Example Code

Here is a complete example that demonstrates how to register and use both the factory and converter for a `User` model:

```dart
class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  // Deserialization: From JSON to User instance
  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }

  // Serialization: From User instance to JSON
  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

void main() {
  // Register the User factory (deserialization)
  JsonFactoryIoc().registerFactory<User>((json) => User.fromJson(json));

  // Register the User converter (serialization)
  JsonConverterIoc().registerConverter<User>((user) => user.toJson());

  // Use the factory to create a User object from JSON
  final userFromJson = factory<User>({'id': 55, 'name': 'John Doe'});

  print('Deserialized User:');
  print('ID: ${userFromJson.id}, Name: ${userFromJson.name}');
  // Output: ID: 55, Name: John Doe

  // Use the converter to convert a User object to JSON
  final userToJson = converter<User>(userFromJson);

  print('Serialized User JSON:');
  print(userToJson); // Output: {id: 55, name: John Doe}
}
```

This example demonstrates how you can:
1. Register a factory to convert JSON data into a `User` object.
2. Register a converter to serialize a `User` object back into JSON.
3. Dynamically perform serialization and deserialization without calling `toJson` or `fromJson` directly.

---

### FAQ

- **How do I register multiple converters or factories?**  
  You can call `registerFactory` or `registerConverter` multiple times to add converters or factories for different models.

- **What happens if I try to retrieve a non-existent factory or converter?**  
  The package throws a custom exception to notify that the requested factory or converter has not been registered.

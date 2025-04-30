class EnumException implements Exception {
  final String type;
  final String value;
  final List<String> values;

  EnumException({required this.type, required this.values, required this.value});

  String get error => "Undefined $type: '$value'. $type can only be one of the following: $values";
}

class ModelException implements Exception {
  final String className;
  final int line;
  final String message;

  ModelException(this.line, {required this.className, required this.message});

  String get error => "$className error at line $line: $message";
}

class FieldException implements Exception {
  final String key;
  final String name;
  final String model;
  final String message;
  final dynamic value;

  FieldException({required this.key, required this.name, required this.model, required this.message, this.value});

  String get error => "$model invalid value${value != null ? "($value)" : ""} of $name($key): $message";

  @override
  String toString() => error;
}

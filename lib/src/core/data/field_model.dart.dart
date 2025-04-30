import 'dart:developer';
import 'package:chat_app/utils/exceptions.dart';

class FieldModel<T> {
  static bool enableLogs = false;
  static bool validationEnabled = false;
  final bool isRequired;
  final bool isNullable;
  final String name;
  final String key;

  const FieldModel({this.isRequired = true, this.isNullable = false, required this.name, required this.key});

  void validateField(String className, Map<String, dynamic> json) {
    if (FieldModel.enableLogs) {
      String value;
      if (json[key] is Map || json[key] is List) {
        value = json[key].runtimeType.toString();
      } else {
        value = json[key].toString();
      }
      log("$name - $key - $value - $T - $isRequired - $isNullable", name: className);
    }
    if (validationEnabled) {
      if (isRequired) {
        if (!json.containsKey(key)) {
          throw FieldException(key: key, name: name, model: className, message: "apiParseIncompleteDataError");
        }
        if (isNullable && json[key] is! T?) {
          throw FieldException(key: key, name: name, value: json[key], model: className, message: "apiParseTypeDataError");
        }
        if (!isNullable && (json[key] == null || json[key] is! T)) {
          throw FieldException(key: key, name: name, value: json[key], model: className, message: "apiParseTypeDataError");
        }
      } else {
        if (isNullable && json.containsKey(key) && json[key] is! T?) {
          throw FieldException(key: key, name: name, value: json[key], model: className, message: "apiParseTypeDataError");
        }
        if (!isNullable && json.containsKey(key) && (json[key] == null || json[key] is! T)) {
          throw FieldException(key: key, name: name, value: json[key], model: className, message: "apiParseTypeDataError");
        }
      }
    }
  }

  static validateFields(Map<String, FieldModel> fields, String name, Map<String, dynamic> json) {
    for (FieldModel field in fields.values) {
      field.validateField(name, json);
    }
  }
}

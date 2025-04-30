import 'package:chat_app/chat_export.dart';
import 'package:chat_app/src/core/data/field_model.dart.dart';

class MessagesModel extends MessagesEntity implements Equatable {
  static const String _name = "MessagesModel";
  static const Map<String, FieldModel> _fields = {
    "data": FieldModel(name: "data", key: "data"),
  };
  MessagesModel({
    required List<Message> messages,
  }) : super(
    messages: messages,
  );

  static MessagesModel fromJson(Map<String, dynamic> json) {
    FieldModel.validateFields(_fields, _name, json);
    var messages = (json[_fields["data"]!.key] as List<dynamic>).map((e) => Message.fromJson(e)).toList();

    return MessagesModel(
      messages: messages,
    );
  }

  @override
  List<Object?> get props => [
    messages,
  ];

  @override
  bool get stringify => true;
}

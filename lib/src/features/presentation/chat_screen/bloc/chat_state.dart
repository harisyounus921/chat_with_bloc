
import 'package:chat_app/chat_export.dart';

sealed class ChatState {}

final class MessageInitialState extends ChatState {}

final class MessagesIdleState extends ChatState {}

final class MessagesLoadingState extends ChatState {}

final class MessagesLoadedState extends ChatState {
  final String message;
  final List<Message> messages;

  MessagesLoadedState(
      this.messages, {
        required this.message,
      });
}

class ChatStartedState extends ChatState {
  final ChatStartedEntity ministryChatStartedEntity;

  ChatStartedState(this.ministryChatStartedEntity);
}


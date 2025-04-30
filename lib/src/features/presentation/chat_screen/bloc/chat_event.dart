import 'package:chat_app/chat_export.dart';

sealed class ChatEvent {}

final class GetMessages extends ChatEvent {
  final int chatId;
  final int page;

  GetMessages({
    required this.chatId,
    required this.page,
  });
}

final class MessagesFetched extends ChatEvent {
  final MessagesEntity ministryMessagesEntity;

  MessagesFetched(this.ministryMessagesEntity);
}

final class SendNewMessage extends ChatEvent {
  final int chatId;
  final String content;
  final String? fileUrl;
  final String messageType;

  SendNewMessage({
    required this.chatId,
    required this.content,
    required this.fileUrl,
    required this.messageType,
  });
}


final class MessageReceived extends ChatEvent {
  final Message ministryMessage;

  MessageReceived({required this.ministryMessage});
}

final class AddMessage extends ChatEvent {
  final String messageContent;
  final String? mediaUrl;
  final String? messageType;
  final String? messageState;

  AddMessage({
    required this.messageContent,
    required this.mediaUrl,
    required this.messageType,
    this.messageState,
  });
}

final class StartChatEvent extends ChatEvent {
  final int partnerUserId;
  final int ministryId;
  StartChatEvent( {required this.partnerUserId, required this.ministryId,});
}

final class ChatStartedEvent extends ChatEvent{
  final ChatStartedEntity ministryChatStartedEntity;
  ChatStartedEvent({required this.ministryChatStartedEntity});
}







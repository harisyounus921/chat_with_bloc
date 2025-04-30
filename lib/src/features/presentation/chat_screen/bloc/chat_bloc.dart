import 'dart:convert';
import 'package:chat_app/chat_export.dart';
import 'package:chat_app/src/features/presentation/chat_screen/bloc/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  int? communityMembers;
  late int pageCount;
  late List<Message> _chatMessages;
  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(MessageInitialState()) {
    on<GetMessages>(handleGetMessagesEvent);
    on<MessagesFetched>(handleMessagesFetchedEvent);
    on<AddMessage>(handleAddMessageEvent);
    on<SendNewMessage>(handleSendMessageEvent);
    on<MessageReceived>(handleReceiveMessageEvent);
    on<StartChatEvent>(handleStartChatEvent);
    on<ChatStartedEvent>(handleChatStartedEvent);
  }

  @override
  void onChange(Change<ChatState> change) {
    super.onChange(change);
    debugPrint('State changed from ${change.currentState} to ${change.nextState}');
  }

  handleStartChatEvent(StartChatEvent event, emit) {
    final body = {"partnerUserId": event.partnerUserId, "ministryId": event.ministryId};
    final jsonString = jsonEncode(body);
    debugPrint("jsonString===>$jsonString");
  }

  void handleChatStartedEvent(ChatStartedEvent event, emit) {
    final ChatStartedEntity ministryChatStartedEntity = event.ministryChatStartedEntity;
    emit(ChatStartedState(ministryChatStartedEntity));
  }

  // Asynchronously fetch messages from the repository
  Future<void> handleGetMessagesEvent(GetMessages event, emit) async {
    emit(MessagesLoadingState());

    final body = {"chatId": event.chatId, "page": event.page, "limit": 10};
    final jsonString = jsonEncode(body);
    debugPrint("jsonString===>$jsonString");

    // Fetch messages from the repository (API call)
    final result = await _chatRepository.viewMessages(body);

    result.fold(
          (failure) {
        // Handle failure, if needed
        emit(MessagesIdleState());
        debugPrint("Error: $failure");
      },
          (messagesEntity) {
        // On success, emit the MessagesLoadedState with the fetched messages
        if (messagesEntity.messages != null && messagesEntity.messages!.isNotEmpty) {
          _chatMessages = messagesEntity.messages!;
          emit(MessagesLoadedState(_chatMessages, message: 'Messages fetched'));
        } else {
          emit(MessagesIdleState());
        }
      },
    );
  }


  handleMessagesFetchedEvent(MessagesFetched event, emit) {
    _chatMessages = event.ministryMessagesEntity.messages!;
    emit(MessagesIdleState());
    emit(MessagesLoadedState(_chatMessages, message: 'Messages fetched'));
  }

  // Adding message to the list to instantly show them to the user
  handleAddMessageEvent(AddMessage event, emit) async {
    if (state is! MessagesLoadedState) {
      return;
    }
    final body = Message(
        content: event.messageContent,
        senderId: 0,
        fileUrl: event.mediaUrl,
        createdAt: DateTime.now().toString(),
        messageType: event.messageType,
        messageState: event.messageState);
    debugPrint("body for adding message is : $body");

    final messages = (state as MessagesLoadedState).messages;
    if (messages.isNotEmpty && messages.first.messageState == "dummy") {
      messages.first = body;
    } else {
      messages.insert(0, body);
    }
    emit(MessagesLoadedState(messages, message: 'Message added'));
  }

  // Sending message to the server
  handleSendMessageEvent(SendNewMessage event, emit) {
    final body = {
      "message": {
        "content": event.content,
        "fileUrl": event.fileUrl,
        "messageType": event.messageType,
      },
      "chatId": event.chatId
    };
    final jsonString = jsonEncode(body);
    debugPrint("jsonString===>$jsonString");
    // socket!.emit('ministryNewMessage', jsonString);
  }

  // Receiving message from the server side and adding it into the list
  handleReceiveMessageEvent(MessageReceived event, emit) {
    if (state is! MessagesLoadedState) {
      return;
    }
    final messages = (state as MessagesLoadedState).messages;
    messages.insert(0, event.ministryMessage);
    emit(MessagesLoadedState(messages, message: 'Message received'));
  }
}

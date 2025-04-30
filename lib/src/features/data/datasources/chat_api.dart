import 'dart:developer';
import 'package:chat_app/chat_export.dart';
import 'package:dartz/dartz.dart';

class ChatApi {
  Future<Either<Failure, MessagesModel>> viewAllMessages({required Map<String, dynamic> date}) async {
      try {
          var list =  MessagesModel(messages: [
            Message(id: 0,senderId: 1,senderName: "Lousiana",content: "Hi how are you?",image: Assets.person1,fileUrl: "",messageType: "text",createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),messageState: "show"),
            Message(id:1,senderId: 1,senderName: "Lousiana",content: "@Tommmy Feeling ok?",image: Assets.person1,fileUrl: "",messageType: "text",createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),messageState: "show"),
            Message(id:2,senderId: 2,senderName: "Tommy",content: "Yes im good. thanks for asking.Didn’t do much. feeling bit sick after that meal. So just exhausted. watching netflux, 😢",image: Assets.person2,fileUrl: "",messageType: "text",createdAt:DateTime.now().subtract(Duration(hours: 1)).toString(),messageState: "show"),
            Message(id:3,senderId: 0,senderName: "me",content: "Yes, Im well. Had a long day. went hiking with the some people.it was  extremely hot couldn’t be bothered in the end. How r U?",image: Assets.person1,fileUrl: "",messageType: "text",createdAt:DateTime.now().subtract(Duration(hours: 1)).toString(),messageState: "show"),
            Message(id:4,senderId: 3,senderName: "Cristofer",content: "Yes im good. thanks for asking.Didn’t do much. feeling bit sick after that meal. So just exhausted. watching netflux",image: Assets.person1,fileUrl: "",messageType: "text",createdAt: DateTime.now().subtract(Duration(hours: 1)).toString(),messageState: "show"),
          ]);
          return Right(list);
      } catch (_) {
        log("$_", name: runtimeType.toString());
        return Left(ParseFailure());
      }
  }
}

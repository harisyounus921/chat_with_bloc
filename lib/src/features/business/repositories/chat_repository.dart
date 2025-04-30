import 'package:chat_app/chat_export.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Failure, MessagesEntity>> viewMessages(Map<String, dynamic> data);
}

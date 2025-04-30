import 'package:chat_app/chat_export.dart';
import 'package:dartz/dartz.dart';

class ChatRepositoryImplementation implements ChatRepository {
  final ChatApi _chatApi = sl.get();

  @override
  Future<Either<Failure, MessagesModel>> viewMessages(Map<String, dynamic> data) => _chatApi.viewAllMessages(date: data);
}
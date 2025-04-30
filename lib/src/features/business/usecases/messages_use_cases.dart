import 'package:chat_app/chat_export.dart';
import 'package:dartz/dartz.dart';

class ChatMessagesUseCase implements UseCase<MessagesEntity, MessagesParams> {
  final ChatRepository repository;

  ChatMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, MessagesEntity>> call(MessagesParams params) async {
    return await repository.viewMessages(params.data);
  }
}

class MessagesParams extends Equatable {
  final Map<String, dynamic> data;

  const MessagesParams({required this.data});

  @override
  List<Object> get props => [data];
}

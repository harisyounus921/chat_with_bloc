import 'package:chat_app/chat_export.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String response;
  ServerFailure(this.response);
}

class ParseFailure extends Failure {}

class CacheFailure extends Failure {}

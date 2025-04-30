import 'package:chat_app/chat_export.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => ChatBloc(sl<ChatRepository>()));

  // Use cases (auth)
  sl.registerLazySingleton(() => ChatMessagesUseCase(sl()));

  // Auth Repository
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImplementation(),);

  // Auth Data Source API
  sl.registerLazySingleton<ChatApi>(() => ChatApi());
}

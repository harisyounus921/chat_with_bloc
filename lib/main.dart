import 'package:chat_app/chat_export.dart';
import 'package:chat_app/src/features/presentation/chat_screen/ui/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MediaQuery.withClampedTextScaling(
            minScaleFactor: 0.8,
            maxScaleFactor: 1.0,
            child: MaterialApp(
              title: 'Chat App',
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              themeMode: ThemeMode.light,
              darkTheme: ThemeData.light(useMaterial3: true),
              home: const ChatScreen(),
            ),
          );
      },
    );
  }
}

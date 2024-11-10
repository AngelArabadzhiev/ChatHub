import 'package:Chat_App/chat_page.dart';
import 'package:Chat_App/contacts_page.dart';
import 'package:Chat_App/login_page.dart';
import 'package:Chat_App/register_page.dart';
import 'package:Chat_App/services/auth_services.dart';
import 'package:Chat_App/utils/brand_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await AuthServices.init();
  runApp(ChangeNotifierProvider(
    create: (BuildContext context) => AuthServices(),
    child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Chat App",
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.black,
        ),
      ),
      home: FutureBuilder<bool>(
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!) {
              return const ChatPage();
            } else {
              return LoginPage();
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
        future: context.read<AuthServices>().isLoggedIn(),
      ),
      routes: {
        "/chat": (context) => const ChatPage(),
        "/login": (context) => LoginPage(),
        "/register": (context) => RegisterPage(),
        "/contacts": (context) => ContactsPage()
      },
    );
  }
}

import 'package:chat/providers/user_provider.dart';
import 'package:chat/ui/chat/chat_screen.dart';
import 'package:chat/ui/home/home_screen.dart';
import 'package:chat/ui/login/login_screen.dart';
import 'package:chat/ui/register/register_screen.dart';
import 'package:chat/ui/rooms/add_room.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

void printToken()async{
String? token = await messaging.getToken();
print("Token is : $token");
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  printToken();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> UserProvider()),
    ],
      child: MyApp()));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return MaterialApp(
      routes: {
       RegisterScreen.routeName : (_) => RegisterScreen(),
        LoginScreen.routName : (_)=> LoginScreen(),
        HomeScreen.routeName : (_)=> HomeScreen(),
        AddRoom.routeName : (_)=> AddRoom(),
        ChatScreen.routeName : (_)=>ChatScreen(),
      },
      initialRoute:provider.fireBaseAuthUser==null ?LoginScreen.routName:HomeScreen.routeName,
      debugShowCheckedModeBanner: false,
    );
  }
}
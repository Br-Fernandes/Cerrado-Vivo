import 'package:cerrado_vivo/core/services/notification/chat_notification_service.dart';
import 'package:cerrado_vivo/pages/conversations_page.dart';
import 'package:cerrado_vivo/pages/home_page.dart';
import 'package:cerrado_vivo/pages/login_page.dart';
import 'package:cerrado_vivo/pages/trade_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyApp().initializeFirebaseApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color.fromARGB(255,83,172,60),
            secondary: Color.fromARGB(255, 255, 234, 0)
          ),
        
        ),
         home: LoginPage(), //AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBQsGGJBvCbJAUI45Ee2W-L3KNy6MT43us',
        appId: '1:391385942371:android:d43084aa7e1498052e6b56',
        messagingSenderId: 'sendid',
        projectId: 'cerrado-vivo',
        storageBucket: 'cerrado-vivo.appspot.com',
      )
    );
  }
}

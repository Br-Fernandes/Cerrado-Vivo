import 'package:cerrado_vivo/services/notification/chat_notification_service.dart';
import 'package:cerrado_vivo/views/pages/home_page.dart';
import 'package:cerrado_vivo/views/pages/login_page.dart';
import 'package:cerrado_vivo/views/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const MyApp().initializeFirebaseApp();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
        navigatorKey: navigatorKey,
        onGenerateRoute: generateRoute, 
        theme: themeData(),
        home: const LoginPage(), //AuthOrAppPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Future<void> initializeFirebaseApp() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBQsGGJBvCbJAUI45Ee2W-L3KNy6MT43us',
        appId: '1:391385942371:android:d43084aa7e1498052e6b56',
        messagingSenderId: 'sendid',
        projectId: 'cerrado-vivo',
        storageBucket: 'cerrado-vivo.appspot.com',
      )
    );
  }
}

ThemeData themeData() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255,83,172,60),
      secondary: const Color.fromARGB(255, 255, 234, 0)
    )
  );  
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/LoginPage':
      return MaterialPageRoute(builder: ((context) => const LoginPage()));
    case '/HomePage':
      return MaterialPageRoute(builder: ((context) => const HomePage()));  
    default:
     return MaterialPageRoute(builder: ((context) => const SplashScreen()));  
  }
}
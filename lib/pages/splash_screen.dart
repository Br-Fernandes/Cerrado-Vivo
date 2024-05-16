import 'package:cerrado_vivo/core/services/auth/auth_firebase_service.dart';
import 'package:cerrado_vivo/pages/home_page.dart';
import 'package:cerrado_vivo/pages/login_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => __SplashScreenState();
}

class __SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo_projeto.png"),
      )
    );
  }

  void _navigateToNextPage() {
    Future.delayed(Duration.zero, () {
      if (AuthFirebaseService.checkLoginStatus()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage())
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage())
        );
      }
    });
  }
}

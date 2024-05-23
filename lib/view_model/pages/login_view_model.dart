import 'package:cerrado_vivo/main.dart';
import 'package:cerrado_vivo/models/auth_form_data.dart';
import 'package:cerrado_vivo/services/auth/auth_service.dart';
import 'package:cerrado_vivo/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel extends ChangeNotifier {
  final AuthService _authService;

  LoginPageViewModel({required AuthService authService})
      : _authService = authService;

  Future<void> handleSubmit(AuthFormData formData) async {
    try {
      if (formData.isLogin) {
        await _authService.login(
          formData.email,
          formData.password,
        );
      } else {
        await _authService.signup(
          formData.name,
          formData.origins,
          formData.email,
          formData.password,
          formData.image,
        );
      }
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } catch (error) {
      // Tratar erro
      rethrow;
    }
  }
}

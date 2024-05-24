import 'package:cerrado_vivo/main.dart';
import 'package:cerrado_vivo/models/auth_form_data.dart';
import 'package:cerrado_vivo/services/auth/auth_service.dart';
import 'package:cerrado_vivo/views/pages/home_page.dart';
import 'package:cerrado_vivo/views/pages/loading_page.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;

  LoginPageViewModel({required AuthService authService})
      : _authService = authService;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> handleSubmit(AuthFormData formData) async {
    try {
      _isLoading = true; // Definir como true antes de iniciar o processo
      notifyListeners(); // Notificar os ouvintes sobre a mudança de estado

      bool isProcessSuccess = false;

      if (formData.isLogin) {
        isProcessSuccess = await _authService.login(
          formData.email,
          formData.password,
        );
      } else {
        isProcessSuccess = await _authService.signup(
          formData.name,
          formData.origins,
          formData.email,
          formData.password,
          formData.image,
        );
      }

      if (isProcessSuccess) {
        if (navigatorKey.currentState != null) {
          navigatorKey.currentState!.pushReplacementNamed('/HomePage');
        }
      } else {
        _errorMessage = 'Erro ao registrar usuário.';
      }
    } catch (error) {
      _errorMessage = 'Erro ao ${ formData.isLogin ? 'logar' : 'registrar'}: $error';
    } finally {
      _isLoading = false; // Definir como false após concluir o processo
      notifyListeners(); // Notificar os ouvintes sobre a mudança de estado
    }
  }
}

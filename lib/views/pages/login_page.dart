import 'dart:ui';

import 'package:cerrado_vivo/models/auth_form_data.dart';
import 'package:cerrado_vivo/utils/constants.dart';
import 'package:cerrado_vivo/views/components/user_form.dart';
import 'package:cerrado_vivo/views/components/header.dart';
import 'package:cerrado_vivo/views/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> handleSubmit(AuthFormData formData) async {
    try {
      _isLoading = true; 
      bool isProcessSuccess = false;

      if (formData.isLogin) {
        isProcessSuccess = await authController.login(
          formData.email,
          formData.password,
        );
      } else {
        isProcessSuccess = await authController.signup(
          formData.name,
          formData.origins,
          formData.email,
          formData.password,
          formData.image,
        );
      }

      if (isProcessSuccess) {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => const HomePage())));
      } else {
        _errorMessage = 'Erro ao registrar usuário.';
      }
    } catch (error) {
      _errorMessage = 'Erro ao ${ formData.isLogin ? 'logar' : 'registrar'}: $error';
    } finally {
      _isLoading = false; // Definir como false após concluir o processo
    }
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 8,
                      child: Center(
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.elliptical(250, 110),
                                bottomRight: Radius.elliptical(100, 50),
                              ),
                              child: Container(
                                color: const Color(0xFF53AC3C),
                                child: UserForm(onSubmit: handleSubmit),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Header(),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(), // Preenchimento inferior de 30% da tela
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


import 'package:cerrado_vivo/components/form.dart';
import 'package:cerrado_vivo/components/header.dart';
import 'package:cerrado_vivo/core/models/auth_form_data.dart';
import 'package:cerrado_vivo/core/services/auth/auth_service.dart';
import 'package:cerrado_vivo/pages/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        // Login
        await AuthService().login(
          formData.email,
          formData.password,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => HomePage()),
        ));
      } else {
        // Signup
        await AuthService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: ((context) => HomePage()),
        ));
      }
    } catch (error) {
      // Tratar erro!
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(250, 110), 
                      bottomRight: Radius.elliptical(100, 50), 
                    ),
                    child: Container(
                      color: Color(0xFF53AC3C),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Header(),
                          LoginForm(onSubmit: _handleSubmit),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(), // Preenchimento inferior de 30% da tela
          ),
        ],
      ),      
    );
  }
}

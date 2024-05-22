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
  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      if (!mounted) return;

      if (formData.isLogin) {
        // Login
        await AuthService().login(
          formData.email,
          formData.password,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const HomePage()),
            ));
      } else {
        // Signup
        await AuthService().signup(
          formData.name,
          formData.origins,
          formData.email,
          formData.password,
          formData.image,
        );
        Navigator.push(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: ((context) => const HomePage()),
            ));
      }
    } catch (error) {
      // Tratar erro!
    } finally {
      // ignore: control_flow_in_finally
      if (!mounted) return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
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
                            child: LoginForm(onSubmit: _handleSubmit),
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
                  flex: 1,
                  child: Container(), // Preenchimento inferior de 30% da tela
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

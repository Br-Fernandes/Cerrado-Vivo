import 'package:cerrado_vivo/models/auth_form_data.dart';
import 'package:cerrado_vivo/services/auth/auth_service.dart';
import 'package:cerrado_vivo/view_model/pages/login_view_model.dart';
import 'package:cerrado_vivo/views/components/user_form.dart';
import 'package:cerrado_vivo/views/components/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final LoginPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LoginPageViewModel(authService: AuthService());
  }

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      await _viewModel.handleSubmit(formData);
    } catch (error) {
      // Tratar erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Consumer<LoginPageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SingleChildScrollView(
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
                                  child: UserForm(onSubmit: _handleSubmit),
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
          );
        },
      ),
    );
  }
}

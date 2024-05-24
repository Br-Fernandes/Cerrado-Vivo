import 'package:cerrado_vivo/view_model/components/user_form_viewmodel.dart';
import 'package:cerrado_vivo/views/components/this_text_form_field.dart';
import 'package:cerrado_vivo/views/components/user_image_picker.dart';
import 'package:cerrado_vivo/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({
    super.key,
    required this.onSubmit,
  });
  final void Function(AuthFormData) onSubmit;

  @override
  State<UserForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserFormViewModel(onSubmit: widget.onSubmit),
      child: Consumer<UserFormViewModel> (
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 80.0,
              bottom: double.minPositive,
            ),
            child: Form(
              key: _formKey, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (viewModel.formData.isSignup)
                    UserImagePicker(
                      onImagePick: viewModel.handleImagePick,
                    ),
                  if (viewModel.formData.isSignup) 
                    ThisTextFormField(
                      key: const ValueKey('name'),
                      label: 'Nome',
                      initialValue: viewModel.formData.name,
                      onChanged: (name) => viewModel.formData.name = name,
                      validator: (localName) {
                        final name = localName ?? '';
                        if (name.trim().length < 5) {
                          return 'Nome deve ter no mínimo 5 caracteres.';
                        }
                        return null;
                      },
                    ),
                  const SizedBox( height: 7,),  
                  if (viewModel.formData.isSignup)   
                    ThisTextFormField(
                      key: const ValueKey('origins'),
                      label: 'Origens',
                      initialValue: viewModel.formData.origins,
                      onChanged: (origins) => viewModel.formData.origins = origins,
                      validator: (localOrigins) {
                        final origins = localOrigins ?? '';
                        if (origins.trim().length < 5) {
                          return 'Nome deve ter no mínimo 5 caracteres.';
                        }
                        return null;
                      },
                    ),
                  const SizedBox( height: 7,),
                  ThisTextFormField(
                    key: const ValueKey('email'),
                    label: 'E-mail',
                    initialValue: viewModel.formData.email,
                    onChanged: (email) => viewModel.formData.email = email,
                    validator: (localEmail) {
                      final email = localEmail ?? '';
                      if (!email.contains('@')) {
                        return 'E-mail informado não é válido.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox( height: 7,),
                  ThisTextFormField(
                    key: const ValueKey('password'),
                    label: 'Senha',
                    initialValue: viewModel.formData.password,
                    onChanged: (password) => viewModel.formData.password = password,
                    validator: (localPassword) {
                      final password = localPassword ?? '';
                      if (password.length < 6) {
                        return 'Senha deve ter no mínimo 6 caracteres.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          viewModel.submit(context, _formKey);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                      ),
                      child: Text(
                        viewModel.formData.isLogin ? 'Entrar' : 'Cadastrar',
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        viewModel.formData.toggleAuthMode();
                      });
                    },
                    child: Text(
                      viewModel.formData.isLogin ? 'Criar uma nova conta?' : 'Já possui conta?',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

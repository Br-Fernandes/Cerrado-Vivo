import 'dart:io';

import 'package:cerrado_vivo/components/this_text_form_field.dart';
import 'package:cerrado_vivo/components/user_image_picker.dart';
import 'package:cerrado_vivo/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.onSubmit,
  });
  final void Function(AuthFormData) onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        top: 20.0,
        bottom: double.minPositive,
      ),
      child: Form(
        key: _formKey, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_formData.isSignup)
              UserImagePicker(
                onImagePick: _handleImagePick,
              ),
            if (_formData.isSignup) 
              ThisTextFormField(
                key: const ValueKey('name'),
                label: 'Nome',
                initialValue: _formData.name,
                onChanged: (name) => _formData.name = name,
                validator: (localName) {
                  final name = localName ?? '';
                  if (name.trim().length < 5) {
                    return 'Nome deve ter no mínimo 5 caracteres.';
                  }
                  return null;
                },
              ),
            const SizedBox( height: 7,),  
            if (_formData.isSignup)   
              ThisTextFormField(
                key: const ValueKey('origins'),
                label: 'Origens',
                initialValue: _formData.origins,
                onChanged: (origins) => _formData.origins = origins,
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
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
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
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password,
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
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submit();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
                ),
                child: Text(
                  _formData.isLogin ? 'Entrar' : 'Cadastrar',
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _formData.toggleAuthMode();
                });
              },
              child: Text(
                _formData.isLogin ? 'Criar uma nova conta?' : 'Já possui conta?',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

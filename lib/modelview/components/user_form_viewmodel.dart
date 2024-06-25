import 'dart:io';
import 'package:cerrado_vivo/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class UserFormViewModel extends ChangeNotifier {
  final AuthFormData _formData = AuthFormData();
  final void Function(AuthFormData) _onSubmit;

  UserFormViewModel({required void Function(AuthFormData) onSubmit})
      : _onSubmit = onSubmit;

  AuthFormData get formData => _formData;

  void handleImagePick(File image) {
    _formData.image = image;
    notifyListeners();
  }

  void showError(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void submit(BuildContext context, GlobalKey<FormState> formKey) {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      showError('Imagem não selecionada!', context);
      return;
    }

    _onSubmit(_formData);
  }
}
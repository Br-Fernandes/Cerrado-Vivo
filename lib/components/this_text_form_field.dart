import 'package:flutter/material.dart';

class ThisTextFormField extends StatelessWidget { 

  final String label;
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  const ThisTextFormField({super.key, required this.label, this.initialValue, required this.onChanged, required this.validator});

  @override
  Widget build(BuildContext context) {

    bool isPassword = label.toLowerCase() == 'senha';

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextFormField(
        key: key,
        initialValue: initialValue,
        onChanged: onChanged,
        validator: validator,
        obscureText: isPassword ? true : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
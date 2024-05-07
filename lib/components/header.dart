import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget {
  const Header({super.key});

   @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 45),
      height: 56, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Cerrado Vivo",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(width: 8), // Espaçamento entre o texto e a imagem
          Flexible(
            child: Image.asset(
              "assets/images/logo_projeto.png", // Caminho da imagem
              width: 60, // Largura da imagem (ajuste conforme necessário)
              height: 60, // Altura da imagem (ajuste conforme necessário)
            ),
          ),
        ],
      ),
    );
  }
}

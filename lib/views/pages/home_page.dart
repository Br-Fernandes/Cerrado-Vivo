import 'package:cerrado_vivo/views/components/header.dart';
import 'package:cerrado_vivo/views/components/video_player.dart';
import 'package:cerrado_vivo/views/pages/social_media.dart';
import 'package:cerrado_vivo/views/pages/species_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF53AC3C),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(),
              HomeCard(),
            ],
          ),
        ]  
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          height: 550,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const VideoPlayerWidget(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpeciesPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Ver Espécies",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // Espaçamento entre os botões
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SocialMedia(),
                            ),
                          );
                        },
                        child: const Text(
                          "Coletores",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // Espaçamento entre as imagens
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Image.asset(
                  'assets/images/grupo_boticario.jpg',
                  width: 85, // Defina a largura desejada
                  height: 85, // Defina a altura desejada
                ),
                Image.asset(
                  'assets/images/ifgoiano.png',
                  width: 85, // Defina a largura desejada
                  height: 85, // Defina a altura desejada
                ),
                Image.asset(
                  'assets/images/fapeg.png',
                  width: 85, // Defina a largura desejada
                  height: 85, // Defina a altura desejada
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:cerrado_vivo/views/components/header.dart';
import 'package:cerrado_vivo/views/components/video_player.dart';
import 'package:cerrado_vivo/views/pages/social_media.dart';
import 'package:cerrado_vivo/views/pages/species_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContentHomePage extends StatelessWidget {
  const ContentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logosSize = MediaQuery.of(context).size.width * 0.2;
    final buttonTextSize = MediaQuery.of(context).size.height * 0.025;

    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Header(),
            SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
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
                              child: Text(
                                "Ver Espécies",
                                style: TextStyle(
                                  fontSize: buttonTextSize,
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
                              child: Text(
                                "Coletores",
                                style: TextStyle(
                                  fontSize: buttonTextSize,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01), // Espaçamento entre as imagens
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Image.asset(
                        'assets/images/grupo_boticario.jpg',
                        width: logosSize, // Defina a largura desejada
                        height: logosSize, // Defina a altura desejada
                      ),
                      Image.asset(
                        'assets/images/ifgoiano.png',
                        width: logosSize, // Defina a largura desejada
                        height: logosSize, // Defina a altura desejada
                      ),
                      Image.asset(
                        'assets/images/fapeg.png',
                        width: logosSize, // Defina a largura desejada
                        height: logosSize, // Defina a altura desejada
                      ),
                    ])
                  ],
                ),
              ),
            ),
            ),
          ],
        ),
      ]),
    );
  }
}
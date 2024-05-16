import 'package:cerrado_vivo/components/header.dart';
import 'package:cerrado_vivo/pages/conversations_page.dart';
import 'package:cerrado_vivo/pages/species_page.dart';
import 'package:cerrado_vivo/pages/trade_page.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF53AC3C),
      body: Stack(
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Header(),
              HomeCard(),
            ],
          ),
          Positioned(
            top: 45,
            right: 16,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConversationsPage(),
                  ),
                );
            },
            icon: const Icon(Icons.message_sharp)),
          )
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
              const VideoPlayer(),
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
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
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
                              builder: (context) => const TradePage(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
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

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({super.key});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/video_teste.mp4");
    _controller.initialize().then((value) {});
    _chewieController = ChewieController(
        videoPlayerController: _controller, autoPlay: false, looping: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: 380,
        height: 200,
        child: AspectRatio(
          aspectRatio: 21 / 9, // Defina a proporção desejada
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _chewieController.dispose();
  }
}

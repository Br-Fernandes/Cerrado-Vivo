import 'package:cerrado_vivo/utils/constants.dart';
import 'package:cerrado_vivo/views/components/header.dart';
import 'package:cerrado_vivo/views/components/video_player.dart';
import 'package:cerrado_vivo/views/pages/social_media.dart';
import 'package:cerrado_vivo/views/pages/species_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            index = idx;
          });
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Você',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Sementes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_rounded),
            label: 'Mensagens',
          ),
        ],
      ),
      body: mainPages[index]
    );
  }
}

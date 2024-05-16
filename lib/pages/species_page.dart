import 'package:cerrado_vivo/core/models/species.dart';
import 'package:cerrado_vivo/pages/specie_details_page.dart';
import 'package:flutter/material.dart';

class SpeciesPage extends StatelessWidget {
  SpeciesPage({super.key});

  final List<Species> speciesList = [
    const Species(
      name: "Jenipapo",
      description: "O jenipapo, cujo nome científico é Genipa americana, é uma árvore frutífera nativa das Américas, encontrada em diversas regiões tropicais. A árvore do jenipapo é conhecida por sua altura impressionante e sua copa densa, que fornece sombra generosa.",
      imagePath: "assets/images/jenipapo.jpg",
    ),
    const Species(
      name: "Pequi",
      description: "O pequi, fruto típico do cerrado brasileiro, é conhecido por sua polpa amarela e sabor marcante. Sua casca espinhosa esconde uma polpa macia e suculenta, com um aroma único que é apreciado em diversas culinárias regionais.",
      imagePath: "assets/images/pequi.jpg",
    ),
    const Species(
      name: "Jatobá",
      description: "O jatobá é uma árvore majestosa encontrada em diversas regiões do Brasil, especialmente na Amazônia e no Cerrado. Reconhecida por sua imponente copa e madeira resistente, o jatobá desempenha um papel fundamental no ecossistema, proporcionando sombra e abrigo para uma grande diversidade de fauna e flora.",
      imagePath: "assets/images/jatoba.jpg",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF53AC3C),
        title: const Text(
          "Selecione uma Espécie",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.tune,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        itemCount: speciesList.length,
        itemBuilder: (context, index) {
          return Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecieDetailsPage(species: speciesList[index]),
                  )
                );
              },
              leading: Image.asset(
                speciesList[index].imagePath,
                width: 50, 
                height: 50, 
              ),
              title: Text(speciesList[index].name),
            ),
            const Divider(
              color: Colors.grey,
              height: 0, 
            ),
          ],
        );
        },
      )
    );
  }
}


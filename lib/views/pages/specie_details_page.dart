import 'package:cerrado_vivo/models/species.dart';
import 'package:flutter/material.dart';

class SpecieDetailsPage extends StatelessWidget {
  final Species species;

  const SpecieDetailsPage({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF53AC3C),
        title: Text(
          species.name,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () { Navigator.of(context).pop(); },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image.asset(
              species.imagePath,
              width: double.infinity,
              height: 150,
            ),
            const SizedBox(height: 10,),
            Text(
              species.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
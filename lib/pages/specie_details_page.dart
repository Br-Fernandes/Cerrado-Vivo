import 'package:cerrado_vivo/core/models/species.dart';
import 'package:flutter/material.dart';

class SpecieDetailsPage extends StatelessWidget {
  final Species species;

  const SpecieDetailsPage({super.key, required this.species});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF53AC3C),
        title: Text(
          species.name,
          style: TextStyle(color: Colors.white),
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
            SizedBox(height: 10,),
            Text(
              species.description,
              style: TextStyle(
                fontSize: 15,
                
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RacesScreen extends StatelessWidget {
  const RacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action à définir
        },
        icon: const Icon(Icons.add),
        label: const Text("Rejoindre une nouvelle course"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Vos courses à venir",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Vos courses passées",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

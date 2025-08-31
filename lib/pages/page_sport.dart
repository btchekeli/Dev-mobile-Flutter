import 'package:flutter/material.dart';

class PageSport extends StatelessWidget {
  const PageSport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green, title: const Text("Sport")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.sports_soccer, color: Colors.green, size: 30),
              title: Text("Résultats et classements"),
              subtitle: Text(
                "Découvrez les résultats en direct et les calendriers.",
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Le sport rassemble toutes les disciplines : football, basketball, tennis et plus encore. "
            "Accédez aux scores en direct et aux dernières performances des athlètes.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

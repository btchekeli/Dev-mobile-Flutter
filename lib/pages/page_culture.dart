import 'package:flutter/material.dart';

class PageCulture extends StatelessWidget {
  const PageCulture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Culture"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const ListTile(
              leading: Icon(Icons.theaters, color: Colors.deepPurple, size: 30),
              title: Text("Événements culturels"),
              subtitle: Text("Théâtre, cinéma, expositions et festivals."),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "La culture englobe les arts, la musique, le cinéma et la littérature. "
            "Découvrez les nouveautés, critiques et rendez-vous artistiques.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

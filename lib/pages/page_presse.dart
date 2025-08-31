import 'package:flutter/material.dart';

class PagePresse extends StatelessWidget {
  const PagePresse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Presse"),
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
              leading: Icon(Icons.article, color: Colors.redAccent, size: 30),
              title: Text("Dernières nouvelles"),
              subtitle: Text(
                "Retrouvez les gros titres et actualités du jour.",
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "La presse regroupe les grands médias d’information, journaux et magazines en ligne. "
            "Accédez ici aux analyses et aux gros titres du moment.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

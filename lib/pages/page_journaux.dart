import 'package:flutter/material.dart';

class PageJournaux extends StatelessWidget {
  const PageJournaux({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Journaux"),
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
              leading: Icon(
                Icons.newspaper,
                color: Colors.blueAccent,
                size: 30,
              ),
              title: Text("Éditions quotidiennes"),
              subtitle: Text("Consultez les journaux nationaux et régionaux."),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Les journaux sont une source incontournable d’information. "
            "Vous trouverez ici des articles d’opinion, des reportages et des enquêtes approfondies.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

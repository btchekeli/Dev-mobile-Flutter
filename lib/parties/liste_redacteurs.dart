import 'package:activite1/parties/ajout_redacteurs.dart';
import 'package:flutter/material.dart';
import 'package:activite1/modeles/redacteurs.dart';

class ListeRedacteurPage extends StatefulWidget {
  const ListeRedacteurPage({super.key});
  @override
  State<ListeRedacteurPage> createState() => _ListeRedacteurPageState();
}

class _ListeRedacteurPageState extends State<ListeRedacteurPage> {
  late Future<List<Redacteur>> redacteurs;

  @override
  void initState() {
    super.initState();
    redacteurs = DatabaseHelper.getAllRedacteurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Liste des rédacteurs",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 255, 90, 100),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<List<Redacteur>>(
        future: redacteurs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucun rédacteur trouvé."));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final redacteur = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text(
                    "${redacteur.prenom} ${redacteur.nom}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(redacteur.email),
                      Divider(),
                      Text(redacteur.role ?? "Non défini"),
                    ],
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Important pour que Row ne prenne pas tout l'espace
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.pink),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AjoutRedacteurs(redacteur: redacteur),
                            ),
                          ).then((value) {
                            setState(() {
                              redacteurs = DatabaseHelper.getAllRedacteurs();
                            });
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          // confirmation avant suppression
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Supprimer ?"),
                              content: Text(
                                "Voulez-vous vraiment supprimer ${redacteur.nom} ?",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text("Annuler"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(
                                    "Supprimer",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true) {
                            await DatabaseHelper.deleteRedacteur(redacteur.id!);
                            setState(() {
                              redacteurs = DatabaseHelper.getAllRedacteurs();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

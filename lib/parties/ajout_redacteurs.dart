import 'package:flutter/material.dart';
import 'package:activite1/modeles/redacteurs.dart';

class AjoutRedacteurs extends StatefulWidget {
  final Redacteur? redacteur;

  const AjoutRedacteurs({this.redacteur, super.key});

  @override
  State<AjoutRedacteurs> createState() => _AjoutRedacteursState();
}

class _AjoutRedacteursState extends State<AjoutRedacteurs> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  late Future<List<Redacteur>> redacteurs;

  @override
  void initState() {
    super.initState();
    if (widget.redacteur != null) {
      nomController.text = widget.redacteur!.nom;
      prenomController.text = widget.redacteur!.prenom;
      emailController.text = widget.redacteur!.email;
      roleController.text = widget.redacteur!.role ?? '';
    }
    redacteurs = DatabaseHelper.getAllRedacteurs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 90, 100),
        title: Text(
          widget.redacteur == null
              ? "Ajouter un rédacteur"
              : "Modifier un rédacteur",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      controller: nomController,
                      decoration: InputDecoration(
                        labelText: "Nom",
                        hintText: "Entrez votre nom",
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: prenomController,
                      decoration: InputDecoration(
                        labelText: "Prénom",
                        hintText: "Entrez votre prénom",
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Entrez votre email",
                        prefixIcon: Icon(Icons.email, color: Colors.blue),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: roleController,
                      decoration: InputDecoration(
                        labelText: "Rôle",
                        prefixIcon: Icon(
                          Icons.assignment_ind,
                          color: Colors.blue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 90, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        if (nomController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            prenomController.text.isNotEmpty) {
                          if (widget.redacteur == null) {
                            final messenger = ScaffoldMessenger.of(context);
                            // Ajout d'un nouveau rédacteur
                            await DatabaseHelper.insertRedacteur(
                              Redacteur(
                                nom: nomController.text,
                                prenom: prenomController.text,
                                email: emailController.text,
                                role: roleController.text,
                              ),
                            );

                            if (!mounted) return;
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Le rédacteur a été ajouté avec succès !",
                                ),
                                //behavior: SnackBarBehavior.floating,
                              ),
                            );
                          } else {
                            final messenger = ScaffoldMessenger.of(context);
                            // Modification d'un rédacteur existant
                            await DatabaseHelper.updateRedacteur(
                              Redacteur(
                                id: widget.redacteur!.id,
                                nom: nomController.text,
                                prenom: prenomController.text,
                                email: emailController.text,
                                role: roleController.text,
                              ),
                            );

                            if (!mounted) return;
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Le rédacteur a été mis à jour avec succès !",
                                ),
                                //behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                          nomController.clear();
                          prenomController.clear();
                          emailController.clear();
                          roleController.clear();
                          setState(() {
                            redacteurs = DatabaseHelper.getAllRedacteurs();
                          }); // Ferme la page après ajout/modif
                        } else {
                          final messenger = ScaffoldMessenger.of(context);
                          // Si nom ou email est vide
                          if (!mounted) return;
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text(
                                "Le nom et l'email ne peuvent pas être vides !",
                              ),
                              //behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      icon: Icon(Icons.save, color: Colors.white),
                      label: Text(
                        widget.redacteur == null
                            ? "Ajouter un rédacteur"
                            : "Modifier le rédacteur",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(width: 36, height: 36),
                    Divider(),
                    const SizedBox(height: 25),
                    const Text(
                      "Liste des rédacteurs",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder<List<Redacteur>>(
                      future: DatabaseHelper.getAllRedacteurs(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Text("Aucun rédacteur trouvé.");
                        }
                        return ListView.builder(
                          shrinkWrap: true, // ⚡ évite conflit avec scroll
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final redacteur = snapshot.data![index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 6,
                              ),
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
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.pink,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AjoutRedacteurs(
                                                  redacteur: redacteur,
                                                ),
                                          ),
                                        ).then((value) {
                                          setState(() {
                                            redacteurs =
                                                DatabaseHelper.getAllRedacteurs();
                                          });
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
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
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  false,
                                                ),
                                                child: Text("Annuler"),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  true,
                                                ),
                                                child: Text(
                                                  "Supprimer",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirm == true) {
                                          await DatabaseHelper.deleteRedacteur(
                                            redacteur.id!,
                                          );
                                          setState(() {
                                            redacteurs =
                                                DatabaseHelper.getAllRedacteurs();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "Le rédacteur a été supprimé avec succès !",
                                                ),
                                              ),
                                            );
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

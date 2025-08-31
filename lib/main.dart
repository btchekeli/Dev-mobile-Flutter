import "package:activite1/parties/ajout_redacteurs.dart";
import "package:flutter/material.dart";
import "package:activite1/parties/partie_titre.dart";
import "package:activite1/parties/partie_texte.dart";
import "package:activite1/parties/partie_rubrique.dart";
import "package:activite1/parties/partie_icone.dart";
import 'package:activite1/parties/liste_redacteurs.dart';
import 'package:activite1/parties/expandable_fab.dart';
import 'package:activite1/modeles/redacteurs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.database; // Pour forcer l'initialisation
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Magazine Infos",
      debugShowCheckedModeBanner: false,
      home: const PageAccueil(),
    );
  }
}

class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  State<PageAccueil> createState() => _PageAccueilState();
}

class _PageAccueilState extends State<PageAccueil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12.0,
        backgroundColor: const Color.fromARGB(255, 255, 90, 100),
        title: const Text(
          "Magazine Infos",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("$value ")));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Déconnexion réussie !",
                child: Text("Déconnexion "),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(225, 225, 95, 90),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 20, // Définit la taille du cercle
                        backgroundImage: AssetImage(
                          'assets/images/Flutter_logo.png',
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Magazine Infos",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text("ajouter un rédacteur"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AjoutRedacteurs(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Liste des rédacteurs"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ListeRedacteurPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Quitter"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset("assets/images/news.jpg", width: 500, height: 250),
            const PartieTitre(),
            const PartieTexte(),
            //const Divider(),
            const PartieIcone(),
            const PartieRubrique(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ExpandableFab(
        distance: 60,
        children: [
          // Ajouter un rédacteur
          FabActionButton(
            icon: const Icon(Icons.person_add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AjoutRedacteurs()),
              );
            },
          ),
          // Liste des rédacteurs
          FabActionButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ListeRedacteurPage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white70,
        elevation: 55,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper, size: 25),
            label: "+ d'infos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert, size: 25),
            label: "Mes alertes",
          ),
        ],
      ),
    );
  }
}

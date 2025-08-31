import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//------------------ Modèle ------------------
class Redacteur {
  final int? id;
  final String nom;
  final String prenom;
  final String email;
  final String? role;

  Redacteur({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    this.role,
  });

  // Map pour l'insertion (sans id)
  Map<String, dynamic> toMapForInsert() {
    return {'nom': nom, 'prenom': prenom, 'email': email, 'role': role};
  }

  // Map pour la mise à jour (avec id)
  Map<String, dynamic> toMapForUpdate() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'role': role,
    };
  }

  // Crée un objet Redacteur à partir d'un Map
  factory Redacteur.fromMap(Map<String, dynamic> map) {
    return Redacteur(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      role: map['role'],
    );
  }
}

//------------------ DatabaseHelper (Singleton) ------------------
class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'redacteurs_database.db';
  static const int _dbVersion = 1;

  // Table et colonnes
  static const String tableRedacteur = 'redacteurs';
  static const String columnId = 'id';
  static const String columnNom = 'nom';
  static const String columnPrenom = 'prenom';
  static const String columnEmail = 'email';
  static const String columnRole = 'role';

  // Getter pour accéder à la base
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialisation de la base
  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableRedacteur(
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnNom TEXT NOT NULL,
            $columnPrenom TEXT NOT NULL,
            $columnEmail TEXT NOT NULL,
            $columnRole TEXT
          )
        ''');
      },
    );
  }

  // Pour fermer la base quand l'application se ferme
  static Future<void> close() async {
    final db = await database;
    db.close();
  }

  //------------------ CRUD ------------------

  // Insertion
  static Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await database;
    return await db.insert(
      tableRedacteur,
      redacteur.toMapForInsert(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mise à jour
  static Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await database;
    return await db.update(
      tableRedacteur,
      redacteur.toMapForUpdate(),
      where: '$columnId = ?',
      whereArgs: [redacteur.id],
    );
  }

  // Suppression
  static Future<int> deleteRedacteur(int id) async {
    final db = await database;
    return await db.delete(
      tableRedacteur,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Récupération de tous les rédacteurs
  static Future<List<Redacteur>> getAllRedacteurs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableRedacteur);

    return List.generate(maps.length, (i) {
      return Redacteur.fromMap(maps[i]);
    });
  }
}

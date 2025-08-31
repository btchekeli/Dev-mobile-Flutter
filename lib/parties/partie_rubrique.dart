import 'package:flutter/material.dart';
import 'package:activite1/pages/page_culture.dart';
import 'package:activite1/pages/page_journaux.dart';
import 'package:activite1/pages/page_presse.dart';
import 'package:activite1/pages/page_sport.dart';

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        shrinkWrap: true, // pour évite les conflits de scroll
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2, // nombre de colonnes
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildCategorie(context, "assets/images/presse.png", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PagePresse()),
            );
          }),
          _buildCategorie(context, "assets/images/journaux.png", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageJournaux()),
            );
          }),
          _buildCategorie(context, "assets/images/vogue.jpg", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageSport()),
            );
          }),
          _buildCategorie(context, "assets/images/presse_variante.jpg", () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageCulture()),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCategorie(
    BuildContext context,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: AspectRatio(
          aspectRatio: 3 / 2,
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

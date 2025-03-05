import 'package:flutter/material.dart';
import 'package:nutrimove/themes/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryClr,
        ),
        alignment: Alignment.center, // 🔹 Wyśrodkowanie zawartości w Container
        child: Text(
          label,
          style: TextStyle(
            color: colorWhite,
            fontSize: 16, // Możesz dostosować rozmiar
            fontWeight: FontWeight.bold, // Opcjonalnie pogrubić tekst
          ),
          textAlign: TextAlign.center, // 🔹 Wyśrodkowanie tekstu poziomo
        ),
      ),
    );
  }
}

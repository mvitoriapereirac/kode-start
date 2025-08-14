import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorMessageComponent extends StatelessWidget {
  final String? errMessage;
  const ErrorMessageComponent(this.errMessage, {super.key});
  
  @override
  Widget build(Object context) {
    errMessage ?? '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          "Houve um erro no carregamento dos dados: \n$errMessage.\n\nPor favor, tente novamente mais tarde.",
          style: GoogleFonts.lato(color: Colors.white, fontSize: 16),
        ),
      ),
   );
  }
}
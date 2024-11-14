import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(338, 44), // Set custom size
        backgroundColor: const Color(0xFF100E09), // Set background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60), // Rounded corners
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFFFFFFFF), // White text color
        ),
      ),
    );
  }
}

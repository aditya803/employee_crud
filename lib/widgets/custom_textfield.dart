import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class CustomTextField extends StatelessWidget {
  TextEditingController? controller;
  String? labelText;
  TextInputType? keyboardType;
  String?Function(String?)? validator;
  String?Function(String?)? onChanged;


   CustomTextField({
    this.controller,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: labelText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border color transparent
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border color transparent
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Colors.transparent, // Make the border color transparent
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          // Optional padding adjustment
        ), // Optional padding adjustment
        keyboardType: keyboardType,
      ),
    );
  }
}
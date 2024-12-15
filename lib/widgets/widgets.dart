import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double getMediaQueryWidth(double number, BuildContext context) {
  return MediaQuery.of(context).size.width * number;
}

double getMediaQueryHeight(double number, BuildContext context) {
  return MediaQuery.of(context).size.height * number;
}

Widget getTextField(
    TextInputType textinputtype,
    String hinttext,
    TextEditingController controller,
    void Function(String text) onChnaged,
    void Function() onEditingComplete) {
  return TextField(
    onEditingComplete: onEditingComplete,
    onChanged: onChnaged,
    keyboardType: textinputtype,
    style: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFE2F4F6),
    ),
    cursorColor: const Color(0xFFE2F4F6),
    controller: controller,
    decoration: InputDecoration(
      hintText: hinttext,
      hintStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: const Color(0xFFE2F4F6),
      ),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFFFF1D4),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFFFF1D4),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFFFFF1D4),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
      ),
    ),
  );
}

Widget getButton(BuildContext context, void Function() onTap) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: getMediaQueryHeight(0.015, context),
        ),
        backgroundColor: const Color(0xFFFFF1D4),
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        'Enter user',
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF29384D),
        ),
      ),
    ),
  );
}

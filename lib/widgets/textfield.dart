import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.obscureValue,
    this.keyboardType,
    this.prefixIcon,
    this.hintText,
    this.labeltext,
    this.fillColor,
    this.fillcolourvalue,
    this.errorText,
    this.validator,
    this.onChanged,
  });

  final TextEditingController controller;
  final bool? obscureValue;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labeltext;
  final Color? fillColor;
  final bool? fillcolourvalue;
  final String? errorText;
  final String? Function(String?)? validator; // Validator function
  final void Function(String)? onChanged; // onChanged function

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureValue ?? false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            errorText: errorText,
            fillColor: fillColor,
            filled: fillcolourvalue,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            prefixIcon: prefixIcon,
            hintText: hintText,
            labelText: labeltext),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final VoidCallback onpressed;
  final String textbutton;
  final Color? textcolor;

  const TextButtonWidget({
    Key? key,
    required this.onpressed,
    required this.textbutton,
    this.textcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onpressed,
      style: TextButton.styleFrom(
        foregroundColor: textcolor,
      ),
      child: Text(textbutton),
    );
  }
}

class ElevatedButtonnWidget extends StatelessWidget {
  final VoidCallback onpressed;
  final String buttontext;
  final Color? backgroundcolor;
  final Color? textcolor;
  final RoundedRectangleBorder? customshape;
  final double? fontsize;
  final FontWeight? fontWeight;
  const ElevatedButtonnWidget({
    super.key,
    required this.onpressed,
    required this.buttontext,
    this.backgroundcolor,
    this.textcolor,
    this.customshape,
    this.fontsize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: textcolor,
          backgroundColor: backgroundcolor,
          shape: customshape),
      child: Text(
        buttontext,
        style: TextStyle(fontSize: fontsize, fontWeight: fontWeight),
      ),
    );
  }
}

void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 2),
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}

class Textwidget extends StatelessWidget {
  const Textwidget({
    super.key,
    required this.title,
    this.textColor,
    this.textsize,
  });
  final String title;
  final Color? textColor;
  final double? textsize;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: textsize ?? 20,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}

class WidgetListTile extends StatelessWidget {
  final String titleText;
  final IconData leaddingtileIcon;
  final IconData? trilingtileIcon;
  final Color tileColor;
  final VoidCallback onTapAction;

  const WidgetListTile({
    required this.tileColor,
    required this.leaddingtileIcon,
    this.trilingtileIcon,
    required this.titleText,
    required this.onTapAction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          leaddingtileIcon,
          color: tileColor,
          size: 25,
        ),
      ),
      trailing: trilingtileIcon != null
          ? Icon(
              trilingtileIcon,
              color: tileColor,
              size: 40,
            )
          : null,
      title: Text(
        titleText,
        style: GoogleFonts.getFont('Ubuntu',
            color: tileColor, fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: onTapAction,
    );
  }
}

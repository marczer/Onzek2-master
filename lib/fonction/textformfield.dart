import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  // const textfield({super.key});

  final String label;
  final TextEditingController;
  final bool textvisible;

  textfield(
      {required this.label,
      this.textvisible = false,
      required this.TextEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController,
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person_outline_rounded,
            color: Color(0xfff9f9f9),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: Colors.black45))),
      obscureText: textvisible ? true : false,
    );
  }
}

class textfield2 extends StatelessWidget {
  // const textfield({super.key});

  final String? hinttext;
  final TextEditingController;
  final bool textvisible;

  textfield2(
      {this.textvisible = false,
      required this.TextEditingController,
      this.hinttext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController,
      // ignore: prefer_const_constructors
      decoration: InputDecoration(
        hintText: hinttext,
        labelStyle: TextStyle(color: Colors.black45),
      ),
      obscureText: textvisible ? true : false,
    );
  }
}

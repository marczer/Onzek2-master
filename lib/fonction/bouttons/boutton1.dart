import 'package:flutter/material.dart';

class boutton1 extends StatelessWidget {
  const boutton1({super.key, required this.title, required this.onPressed});

  final String title;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              side: BorderSide(color: Color(0XFF41cdfb)),
              backgroundColor: Color(0xFFf9f9f9),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9))),
          child: Text(title,
              style: TextStyle(fontSize: 20, color: Color(0XFF41cdfb))),
        ));
  }
}

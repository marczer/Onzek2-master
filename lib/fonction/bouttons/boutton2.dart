import 'package:flutter/material.dart';

import '../../screens/registration/login.dart';

class boutton2 extends StatelessWidget {
  const boutton2(
      {super.key, required this.title, required Null Function() onPressed});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => connection(),
                ));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF41cdfb),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9))),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          )),
    );
  }
}

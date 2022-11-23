import 'package:flutter/material.dart';
import 'package:onzek/fonction/textformfield.dart';
import 'package:onzek/service/firebasehelper.dart';

import '../../fonction/bouttons/largebutton.dart';
import 'login.dart';

class Resetpass extends StatefulWidget {
  const Resetpass({super.key});

  @override
  State<Resetpass> createState() => _ResetpassState();
}

class _ResetpassState extends State<Resetpass> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var largeur = queryData.size.width;
    var hauteur = queryData.size.height;

    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Color(0xfff9f9f9)),
          padding: EdgeInsets.only(
              bottom: 10,
              left: largeur * 0.04,
              right: largeur * 0.04,
              top: hauteur * 0.12),
          child: Form(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Recuperation du mot de pass",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: hauteur * 0.05,
                ),
                Container(
                  height: hauteur * 0.06,
                  child: textfield(
                      label: "Email", TextEditingController: _emailController),
                ),
                SizedBox(
                  height: hauteur * 0.04,
                ),
                SizedBox(
                  height: hauteur * 0.009,
                ),
                largebutton(
                  text: 'Reinitialisé',
                  onPressed: (() async {
                    bool assai = await FirebaseHelper()
                        .Resetpassword(_emailController.text);
                    if (assai) {
                      _isSend();
                    } else {
                      _isNotSend();
                    }
                    ;
                  }),
                ),
                SizedBox(
                  height: hauteur * 0.04,
                ),
                SizedBox(
                  height: hauteur * 0.015,
                ),
                SizedBox(
                  height: hauteur * 0.03,
                ),
                SizedBox(
                  height: hauteur * 0.19,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _isNotSend() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Information!!!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
            content: Container(
              child: Text("Le format de votre address saisie est incorrect"),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 4, 4),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      ;
                    },
                    child: Text("Fermer")),
              )
            ],
          );
        });
  }

  void _isSend() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Information',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.lightBlueAccent.shade400),
            ),
            content: Container(
              child: Text(
                  "Un mail contenant les informations relatif à votre compte a l'address que vous avez saisie "),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => connection(),
                          ));
                    },
                    child: Text("Valider")),
              )
            ],
          );
        });
  }
}

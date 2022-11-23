import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onzek/screens/registration/home.dart';
import 'package:onzek/screens/registration/signup.dart';
import 'package:onzek/fonction/bouttons/largebutton.dart';
import 'package:onzek/fonction/textformfield.dart';
import 'package:onzek/screens/userpage/Acceuil.dart';
import 'package:onzek/service/firebasehelper.dart';

import 'resetpassword.dart';

class connection extends StatefulWidget {
  const connection({super.key, String? title});

  @override
  State<connection> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<connection> {
  bool check = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  // void initState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print("Pas d'utilisateur connecté!");
  //     } else {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => homeuser()));
  //     }
  //   });
  // }

  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var largeur = queryData.size.width;
    var hauteur = queryData.size.height;

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
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
                      "Connexion",
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
                        label: "Email",
                        TextEditingController: _emailController),
                  ),
                  SizedBox(
                    height: hauteur * 0.04,
                  ),
                  Container(
                      height: hauteur * 0.06,
                      child: textfield(
                          label: "Password",
                          TextEditingController: _passwordController)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Resetpass(),
                                  ));
                            },
                            child: Text("Mot de pass oublié?"))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hauteur * 0.009,
                  ),
                  largebutton(
                    text: 'CONNEXION',
                    onPressed: sigin,
                  ),
                  SizedBox(
                    height: hauteur * 0.04,
                  ),
                  Text(
                    "Ou continuer avec",
                    style: TextStyle(fontSize: 17, color: Colors.black45),
                  ),
                  SizedBox(
                    height: hauteur * 0.015,
                  ),
                  transbutton(
                      onPressed: FirebaseHelper().signInWithGoogle,
                      image: 'assets/images/google.png',
                      text: 'Google'),
                  SizedBox(
                    height: hauteur * 0.03,
                  ),
                  transbutton(
                      image: 'assets/images/facebook.png', text: 'Facebook'),
                  SizedBox(
                    height: hauteur * 0.19,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous n'avez pas de compte?",
                        style: TextStyle(fontSize: 15, color: Colors.black45),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const signup(),
                                ));
                          },
                          child: const Text("Creer"))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  sigin() {
    if (_emailController.text != "") {
      if (_passwordController.text != "'") {
        FirebaseHelper()
            .handleSignIn(_emailController.text, _passwordController.text)
            .then((user) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                title: '',
                              )))
                })
            .catchError((error) {
          print(error);
        });
      } else {
        print("Mot de pass vide!");
      }
    } else {
      print("Email vide");
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onzek/screens/registration/home.dart';
import 'package:onzek/screens/registration/login.dart';
import 'package:onzek/fonction/bouttons/largebutton.dart';
import 'package:onzek/fonction/textformfield.dart';
import 'package:onzek/screens/userpage/Acceuil.dart';
import 'package:onzek/service/firebasehelper.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool check = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nom = TextEditingController();
  final _prenom = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var largeur = queryData.size.width;
    var hauteur = queryData.size.height;
    return Scaffold(
      backgroundColor: Color(0xfff9f9f9),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  bottom: 10,
                  left: largeur * 0.04,
                  right: largeur * 0.04,
                  top: hauteur * 0.12),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Se connecter",
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
                      label: "Email*",
                      textvisible: false,
                      TextEditingController: _emailController,
                    ),
                  ),
                  SizedBox(
                    height: hauteur * 0.025,
                  ),
                  Container(
                    height: hauteur * 0.06,
                    child: textfield(
                      label: "Nom",
                      textvisible: false,
                      TextEditingController: _nom,
                    ),
                  ),
                  SizedBox(
                    height: hauteur * 0.025,
                  ),
                  Container(
                    height: hauteur * 0.06,
                    child: textfield(
                      label: "Prenom",
                      textvisible: false,
                      TextEditingController: _prenom,
                    ),
                  ),
                  SizedBox(
                    height: hauteur * 0.025,
                  ),
                  Container(
                    height: hauteur * 0.06,
                    child: textfield(
                      label: "Creer mot de passe*",
                      textvisible: false,
                      TextEditingController: _passwordController,
                    ),
                  ),
                  SizedBox(
                    height: hauteur * 0.025,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          checkColor: Colors.black45,
                          activeColor: Colors.transparent,
                          autofocus: true,
                          value: check,
                          onChanged: (bool? value) {
                            setState(() {
                              check = value!;
                            });
                          },
                        ),
                        const Text(
                          'Se souvenir de moi',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: hauteur * 0.01,
                  ),
                  largebutton(
                    text: 'CONNEXION',
                    onPressed: register,
                  ),
                  SizedBox(
                    height: hauteur * 0.02,
                  ),
                  const Text(
                    "Ou continuer avec",
                    style: TextStyle(fontSize: 16, color: Colors.black45),
                  ),
                  SizedBox(
                    height: hauteur * 0.02,
                  ),
                  transbutton(
                      image: 'assets/images/google.png', text: 'Google'),
                  SizedBox(
                    height: hauteur * 0.02,
                  ),
                  transbutton(
                      image: 'assets/images/facebook.png', text: 'Facebook'),
                  SizedBox(
                    height: hauteur * 0.07,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous avez deja un compte?",
                        style: TextStyle(fontSize: 15, color: Colors.black45),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => connection(),
                                ));
                          },
                          child: const Text("Se connecter"))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  register() {
    if (_emailController.text != "") {
      if (_nom.text != "") {
        if (_passwordController.text != "") {
          if (_prenom.text != "") {
            FirebaseHelper()
                .create(_emailController.text, _passwordController.text,
                    _prenom.text, _nom.text)
                .then((value) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyHomePage(
                            title: '',
                          )));
            });
          } else {
            print("Prenom vide");
          }
        } else {
          print("Mot de pass vide");
        }
      } else {
        print("Numero vide!!");
      }
    } else {
      print("Email vide!!");
    }
  }
}

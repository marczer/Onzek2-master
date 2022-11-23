import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onzek/fonction/Intro.dart';
import 'package:onzek/screens/userpage/Acceuil.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key, required String title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("Pas d'utilisateur connecté!");
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      title: '',
                    )));
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      body: PageView(
        controller: controller,
        // physics: const NeverScrollableScrollPhysics(),
        children: [
          Intro(
            image: Image.asset('assets/images/screen1.png'),
            title: "conversez à travers le monde",
            description:
                "Bienvenu(e) sur la meilleure application de messagerie instantanée permettant à un(e) internaute connecté(e) de rentrer en temps réel en communication.",
            noOfScreen: 3,
            onNextPressed: ecranchange,
            currentScreenNo: 0,
          ),
          Intro(
            image: Image.asset('assets/images/screen2.png'),
            title: "Une connexion internet rapide",
            description:
                "Permet d'envoyer et de recevoir des messages. Elle permet également de gérer des contacts, des rendez-vous ...",
            noOfScreen: 3,
            onNextPressed: ecranchange,
            currentScreenNo: 1,
          ),
          Intro(
            image: Image.asset('assets/images/screen3.png'),
            title: "Echangez avec vos groupes d'amis",
            description:
                "Contrairement au courrier électronique, ce moyen de communication permet de conduire un dialogue interactif",
            noOfScreen: 3,
            onNextPressed: ecranchange,
            currentScreenNo: 2,
          ),
        ],
      ),
    );
  }

  void ecranchange(int nextScreenNo) {
    controller.animateToPage(nextScreenNo,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}

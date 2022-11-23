import 'package:flutter/material.dart';
import 'package:onzek/fonction/bouttons/largebutton.dart';
import 'package:onzek/screens/registration/login.dart';
import 'package:onzek/screens/userpage/Acceuil.dart';
import 'package:onzek/screens/userpage/Settings/myprofilpage.dart';
import 'package:onzek/screens/userpage/utilisateur.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onzek/service/usermodel.dart';

class homeuser extends StatefulWidget {
  // const homeuser({super.key});

  @override
  State<homeuser> createState() => _homeuserState();
}

class _homeuserState extends State<homeuser> {
  MyUser? me;
  final User? user = FirebaseHelper().auth.currentUser;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 150, left: 100, right: 100),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MonCompte()));
                  },
                  child: Text("Profil ")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  title: '',
                                )));
                  },
                  child: Text("HomePage ")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => contact()));
                  },
                  child: Text("Message ")),
              largebutton(
                text: "Deconexion",
                onPressed: _logout,
              )
            ],
          ),
        ),
      ),
    );
  }

  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }

  _logout() {
    FirebaseHelper()
        .handleLogOut()
        .then((user) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => connection(
                            title: '',
                          )))
            })
        .catchError((error) {
      print(error);
    });
  }
}

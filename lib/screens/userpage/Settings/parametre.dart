import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onzek/screens/registration/home.dart';
import 'package:onzek/screens/registration/login.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:onzek/service/usermodel.dart';

import '../Acceuil.dart';
import 'myprofilpage.dart';

class para extends StatefulWidget {
  const para({
    super.key,
  });

  @override
  State<para> createState() => _paraState();
}

final ButtonStyle style = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    textStyle: const TextStyle(fontSize: 20),
    backgroundColor: Color(0xff41CDFB));

class _paraState extends State<para> {
  MyUser? me;
  final User? user = FirebaseHelper().auth.currentUser;

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                'voulez-vous vraiment vous déconnecter',
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 100,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 4, 4),
                        ),
                        onPressed: _logout,
                        child: Text("Deconnexion")),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Annuler")),
                  ],
                ),
              ));
        });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff41CDFB),
          title: Text('Parametre'),
          centerTitle: true,
        ),
        body: Container(
          color: Color(0xfff9f9f9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MonCompte(),
                        ));
                  },
                  child: Card(
                    color: Color(0xffe6f9ff),
                    // margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: ListTile(
                      leading: Text('Mon profil'),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MonCompte(),
                                ));
                          },
                          icon: Icon(Icons.arrow_forward,
                              color: Color(0xff41CDFB))),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: InkWell(
                  onTap: _showDialog,
                  child: Card(
                    color: Color(0xffe6f9ff),
                    child: ListTile(
                      leading: Text('Deconnexion'),
                      trailing: IconButton(
                          onPressed: _showDialog,
                          icon: Icon(Icons.logout_outlined,
                              color: Color(0xff41CDFB))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
              ),
            ],
          ),
        ));
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

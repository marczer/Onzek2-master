import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/fonction/bouttons/boutton1.dart';
import 'package:onzek/fonction/bouttons/boutton2.dart';
import 'package:onzek/fonction/bouttons/largebutton.dart';
import 'package:onzek/fonction/textformfield.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:onzek/service/usermodel.dart';

import 'parametre.dart';

class MonCompte extends StatefulWidget {
  @override
  State<MonCompte> createState() => _MonCompteState();
}

class _MonCompteState extends State<MonCompte> {
  bool cachPassword = true;
  final _nom = TextEditingController();
  final _prenoms = TextEditingController();
  User? user = FirebaseHelper().auth.currentUser;
  MyUser? me;

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                'Modifier photo de profil',
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 400,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      child: CustomImage(
                        color: Colors.black.withOpacity(0.1),
                        imageUrl: me?.imageUrl,
                        initiales: me?.initiales,
                        radius: 50,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            _takeApic(ImageSource.camera);
                          },
                          child: Text(
                            'prendre une photo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            _takeApic(ImageSource.gallery);
                          },
                          child: Text(
                            'importer une image',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Close"))
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

  Widget build(BuildContext context) {
    return (user == null)
        ? const Scaffold(
            body: Center(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff41CDFB),
              title: Text(
                'Mon Compte',
                textAlign: TextAlign.start,
              ),
            ),
            body: Container(
              color: Color(0xfff9f9f9),
              padding: EdgeInsets.only(left: 15, top: 20, right: 15),
              child: GestureDetector(
                onTap: () {},
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Center(
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 130,
                                      child: CustomImage(
                                        color: Colors.black.withOpacity(0.1),
                                        imageUrl: me?.imageUrl,
                                        initiales: me?.initiales,
                                        radius: 50,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            width: 4,
                                            color: Colors.white,
                                          ),
                                          color: Color(0xff41CDFB),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            _showDialog();
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     IconButton(
                              //       iconSize: 35,
                              //       color: Color(0xff41CDFB),
                              //       onPressed: () {
                              //         _takeApic(ImageSource.camera);
                              //       },
                              //       icon: Icon(Icons.camera_enhance),
                              //     ),
                              //     IconButton(
                              //       iconSize: 35,
                              //       color: Color(0xff41CDFB),
                              //       onPressed: () {
                              //         _takeApic(ImageSource.gallery);
                              //       },
                              //       icon: Icon(Icons.photo_album),
                              //     ),
                              //   ],
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    textfield2(hinttext: me?.nom, TextEditingController: _nom),
                    SizedBox(
                      height: 15,
                    ),
                    textfield2(
                        hinttext: me?.prenoms, TextEditingController: _prenoms),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // boutton1(
                        //   title: 'Annuler',
                        //   onPressed: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => para(),
                        //         ));
                        //   },
                        // ),

                        // boutton2(title: 'enregistrer', onPressed: upDateUser()),
                      ],
                    ),
                    largebutton(
                      text: 'Enregistrer',
                      onPressed: upDateUser,
                    )
                  ],
                ),
              ),
            ));
  }

// cette fonction permet de recuperer l'image du user ensuite mettre l'url sur firebase
  Future<void> _takeApic(ImageSource source) async {
    final XFile? img = await ImagePicker()
        .pickImage(source: source, maxHeight: 500, maxWidth: 500);
    if (img != null) {
      File file = File(img.path);
      FirebaseHelper.savePic(file, FirebaseHelper.entryUser.child(me!.uid))
          .then((str) {
        Map map = me!.toMap();
        map["imageUrl"] = str;

        FirebaseHelper().addUser(me!.uid, map);
        _getUser();
      });
    }
  }

// cette fontion permet de recuperer les info du user depuis firebase
  _getUser() {
    FirebaseHelper().getUser(user!.uid).then((me) {
      setState(() {
        this.me = me;
        print("me-----${me.nom}");
      });
    });
  }

// cette fontion permet de mettre a jour les donnees du user firebase
  upDateUser() {
    Map map = me!.toMap();
    if (_prenoms.text != "" && _prenoms.text != null) {
      map["prenoms"] = _prenoms.text;
    }
    if (_nom.text != "" && _nom.text != null) {
      map["nom"] = _nom.text;
    }
    FirebaseHelper().addUser(me!.uid, map);
    _getUser();
  }
}

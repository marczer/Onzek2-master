import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/fonction/personcompte.dart';
import 'package:onzek/screens/userpage/chatcontroller.dart';
import 'package:onzek/screens/userpage/inbox.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:onzek/service/usermodel.dart';

class contact extends StatefulWidget {
  const contact({super.key});

  @override
  State<contact> createState() => _contactState();
}

class _contactState extends State<contact> {
  @override
  Widget build(BuildContext context) {
    var largeur = MediaQuery.of(context).size.width;
    var hauteur = MediaQuery.of(context).size.height;

    return Container(
        height: hauteur,
        width: largeur * 0.9,
        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: FirebaseAnimatedList(
          query: FirebaseHelper.userEntry,
          sort: (a, b) => (a
              .child('prenoms')
              .value
              .toString()
              .toLowerCase()
              .compareTo(b.child('prenoms').value.toString().toLowerCase())),
          itemBuilder: (BuildContext ctx, DataSnapshot snap,
              Animation<double> animation, int index) {
            MyUser newUser = MyUser(snap);
            if (FirebaseHelper().auth.currentUser!.uid == newUser.uid) {
              return Container();
            } else {
              return Column(
                children: [
                  // ListTile(
                  //   leading: CustomImage(
                  //     color: Color(0XFFEA5863),
                  //     imageUrl: newUser.imageUrl,
                  //     initiales: newUser.initiales,
                  //     radius: 20,
                  //   ),
                  //   title: InkWell(
                  //     onTap: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return ChatController(
                  //           partenaire: newUser,
                  //         );
                  //       }));
                  //     },
                  //     child: Row(
                  //       children: [
                  //         Text(newUser.nom),
                  //         Text(newUser.prenoms),
                  //       ],
                  //     ),
                  //   ),
                  //   subtitle: Text('Ecrivez moi'),
                  //   trailing: IconButton(
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return ChatController(
                  //           partenaire: newUser,
                  //         );
                  //       }));
                  //     },
                  //     icon: Icon(Icons.message),
                  //   ),

                  // )  var nom = newUser.prenoms +

                  Card(
                    color: Color(0xffe6f9ff),
                    // margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    child: ListTile(
                      leading: CustomImage(
                        color: Color(0XFFEA5863),
                        imageUrl: newUser.imageUrl,
                        initiales: newUser.initiales,
                        radius: 20,
                      ),
                      title: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatController(
                              partenaire: newUser,
                            );
                          }));
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 150,
                                child: Text(
                                  newUser.nom! + " ${newUser.prenoms}",
                                  style: TextStyle(letterSpacing: 0.9),
                                )),
                            // Text("${newUser.prenoms.length < 10}"),
                          ],
                        ),
                      ),
                      subtitle: Text('Ecrivez moi'),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatController(
                              partenaire: newUser,
                            );
                          }));
                        },
                        icon: Icon(Icons.message),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}

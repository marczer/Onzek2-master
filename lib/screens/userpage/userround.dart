import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/fonction/personcompte.dart';
import 'package:onzek/screens/userpage/chatcontroller.dart';
import 'package:onzek/screens/userpage/inbox.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:onzek/service/usermodel.dart';

class contact2 extends StatefulWidget {
  const contact2({super.key});

  @override
  State<contact2> createState() => _contactState();
}

class _contactState extends State<contact2> {
  @override
  Widget build(BuildContext context) {
    var largeur = MediaQuery.of(context).size.width;
    var hauteur = MediaQuery.of(context).size.height;
    return Container(
        height: 80,
        margin: EdgeInsets.only(left: 15, right: 15),
        child: FirebaseAnimatedList(
          scrollDirection: Axis.horizontal,
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
            if (FirebaseHelper().auth.currentUser?.uid == newUser.uid) {
              return Container();
            } else {
              return SizedBox(
                height: 60,
                width: 50,
                child: ListView(scrollDirection: Axis.horizontal,
                    // height: 60,
                    // width: 60,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatController(
                              partenaire: newUser,
                            );
                          }));
                        },
                        child: AbsorbPointer(
                          child: CustomImage(
                            color: Color(0XFFEA5863),
                            imageUrl: newUser.imageUrl,
                            initiales: newUser.initiales,
                            radius: 25,
                          ),
                        ),
                      ),
                    ]
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

                    // )

                    ),
              );
            }
          },
        ));
  }
}

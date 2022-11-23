import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/getwidget.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/screens/registration/login.dart';
import 'package:onzek/screens/userpage/Settings/messagepage.dart';
import 'package:onzek/screens/userpage/Settings/parametre.dart';
import 'package:onzek/screens/userpage/chatcontroller.dart';
import 'package:onzek/screens/userpage/userround.dart';

import 'package:onzek/screens/userpage/utilisateur.dart';
import 'package:onzek/service/usermodel.dart';
import '../../fonction/personcompte.dart';
import '../../service/firebasehelper.dart';
import 'inbox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum MenuItem {
  item1,
  item2,
}

class _MyHomePageState extends State<MyHomePage> {
  User user = FirebaseHelper().auth.currentUser!;

  @override
  MyUser? me;
  void initState() {
    _getUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    var largeur = MediaQuery.of(context).size.width;
    var hauteur = MediaQuery.of(context).size.height;
    return (user == null)
        ? const Scaffold(
            body: Center(
              child: GFLoader(
                type: GFLoaderType.ios,
              ),
            ),
          )
        : Scaffold(
            body: DefaultTabController(
              length: 2,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 45, 0, 0),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              child: CustomImage(
                                color: Color(0XFFEA5863),
                                imageUrl: me?.imageUrl,
                                initiales: me?.initiales,
                                radius: 20,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${me?.nom}"),
                                Text('${me?.prenoms}'),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            PopupMenuButton(
                              onSelected: (value) {
                                if (value == MenuItem.item1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => para(),
                                      ));
                                } else if (value == MenuItem.item2) {}
                              },
                              icon: Icon(Icons.menu),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry>[
                                PopupMenuItem(
                                  value: MenuItem.item1,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.settings)),
                                      Text(
                                        'Parametre',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      constraints: BoxConstraints.expand(height: 40),
                      child: const TabBar(
                          labelColor: Color(0xff41CDFB),
                          indicatorColor: Color(0xff41CDFB),
                          indicatorWeight: 3,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              child: Text(
                                'Discutions',
                                maxLines: 1,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Mes contacts',
                                maxLines: 1,
                              ),
                            ),
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(children: [
                      ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 40,
                                child: Container(child: contact2()),
                              ),
                              Container(child: MessageController()),
                            ],
                          ),
                        ],
                      ),
                      ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          Column(
                            children: [contact()],
                          ),
                        ],
                      ),
                    ])),
                  ],
                ),
              ),
            ),
          );
  }

  _getUser() {
    FirebaseHelper().getUser(user.uid).then((me) {
      setState(() {
        this.me = me;
      });
    });
  }
}

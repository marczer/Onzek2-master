import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/screens/userpage/chatbuble.dart';
import 'package:onzek/screens/userpage/zonedetext.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:onzek/service/message_model.dart';
import 'package:onzek/service/usermodel.dart';

class ChatController extends StatefulWidget {
  final MyUser partenaire;
  const ChatController({Key? key, required this.partenaire}) : super(key: key);

  @override
  _ChatControllerState createState() => _ChatControllerState();
}

class _ChatControllerState extends State<ChatController> {
  User? user = FirebaseHelper().auth.currentUser;

  MyUser? me;
  @override
  void initState() {
    super.initState();
    String uid = FirebaseHelper().auth.currentUser!.uid;
    FirebaseHelper().getUser(uid).then((user) {
      setState(() {
        me = user;
      });
    });
  }

  @override
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
              automaticallyImplyLeading: true,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomImage(
                    color: Color(0xff41CDFB),
                    imageUrl: widget.partenaire.imageUrl,
                    initiales: widget.partenaire.initiales,
                    radius: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 200,
                    child: Text(
                      widget.partenaire.nom!,
                    ),
                  ),
                ],
              ),
            ),
            body: InkWell(
              //ontap pour refermer le clavier
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  Flexible(
                      child: (me != null)
                          ? FirebaseAnimatedList(
                              query: FirebaseHelper.entryMessage.child(
                                  FirebaseHelper().getMessageRef(
                                      me!.uid, widget.partenaire.uid)),
                              sort: (a, b) => b.key!.compareTo(a.key!),
                              reverse: true,
                              itemBuilder: (BuildContext ctx, DataSnapshot snap,
                                  Animation<double> animation, int index) {
                                Message msg = Message(snap);
                                return ChatBubble(
                                    partenaire: widget.partenaire,
                                    message: msg,
                                    animation: animation);
                                // ListTile(title: Text(msg.text!));
                              })
                          : Center(
                              child: GFLoader(
                                type: GFLoaderType.ios,
                              ),
                            )),
                  Divider(
                    height: 2,
                  ),
                  ZoneDeTexte(
                    partenaire: widget.partenaire,
                    me: me,
                  )
                ],
              ),
            ),
          );
  }
}

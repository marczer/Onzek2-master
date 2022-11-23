import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/screens/userpage/chatcontroller.dart';
import 'package:onzek/service/conversation.dart';
import 'package:onzek/service/datehelper.dart';
import 'package:onzek/service/firebasehelper.dart';

class MessageController extends StatefulWidget {
  const MessageController({Key? key}) : super(key: key);

  @override
  _MessageControllerState createState() => _MessageControllerState();
}

class _MessageControllerState extends State<MessageController> {
  String uid = FirebaseHelper().auth.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.7,
      child: FirebaseAnimatedList(
          query: FirebaseHelper.entryConversation.child(uid),
          sort: (a, b) => b.key!.compareTo(a.key!),
          reverse: true,
          itemBuilder: (BuildContext ctx, DataSnapshot snap,
              Animation<double> animation, int index) {
            Conversation conversation = Conversation(snap);
            String sub = (conversation.uid == uid) ? "Moi : " : "";
            sub += ("${conversation.msg}");
            return Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Column(
                children: [
                  Card(
                    color: Color(0xffe6f9ff),
                    child: ListTile(
                      leading: CustomImage(
                        color: Color(0XFFEA5863),
                        imageUrl: conversation.user!.imageUrl,
                        initiales: conversation.user!.initiales,
                        radius: 20,
                      ),
                      title: Text("${conversation.user!.nom}"),
                      subtitle: Text(sub),
                      trailing: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child:
                                Text(DateHelper().convert(conversation.date!)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CircleAvatar(
                                backgroundColor: Color(0xff41CDFB),
                                radius: 8,
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                      onTap: () async {
                        Future.delayed(Duration(milliseconds: 5), () async {
                          await Navigator.of(context).push(
                              MaterialPageRoute(builder: (BuildContext ctx) {
                            return ChatController(
                                partenaire: conversation.user!);
                          }));
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}

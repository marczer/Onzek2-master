import 'package:flutter/material.dart';
import 'package:onzek/fonction/bouttons/Customimage.dart';
import 'package:onzek/service/datehelper.dart';
import 'package:onzek/service/firebasehelper.dart';
import 'package:onzek/service/message_model.dart';
import 'package:onzek/service/usermodel.dart';

class ChatBubble extends StatefulWidget {
  final MyUser partenaire;
  final Message message;
  final Animation<double> animation;

  ChatBubble(
      {Key? key,
      required this.partenaire,
      required this.message,
      required this.animation})
      : super(key: key);

  @override
  State<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  final String myUid = FirebaseHelper().auth.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    //SizeTransition pour que chatbubble prenne la taille du sms
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: widget.animation, curve: Curves.easeIn),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: bubble(myUid == widget.message.from),
          ),
        ));
  }

  //bubble pour que la bulle se place en fonction de celui qui envoie le sms
  List<Widget> bubble(bool moi) {
    double radius = 20;
    CrossAxisAlignment alignment =
        (moi) ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Color? color = (moi) ? Color(0xffe6f9ff) : Color(0xff41CDFB);

    BoxDecoration deco1 = BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        ));
    BoxDecoration deco2 = BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        ));

    return <Widget>[
      (moi)
          ? Padding(padding: EdgeInsets.all(5.0))
          : CustomImage(
              color: Color(0XFFEA5863),
              imageUrl: widget.partenaire.imageUrl,
              initiales: widget.partenaire.initiales,
              radius: 15,
            ),
      Expanded(
          child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          ClipPath(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 45,
              decoration: (moi) ? deco1 : deco2,
              padding: EdgeInsets.all(
                  (widget.message.imageUrl.isNotEmpty) ? 15 : 10),
              child: (widget.message.text.isNotEmpty)
                  ? Text(
                      widget.message.text,
                      style: TextStyle(color: Colors.black),
                    )
                  : Container(),
            ),
          )
        ],
      )),
    ];
  }
}

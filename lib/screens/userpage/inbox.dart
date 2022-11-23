import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:grouped_list/grouped_list.dart';

import 'Acceuil.dart';

class Message {
  final String text;
  final DateTime data;
  final bool textme;

  const Message({
    required this.text,
    required this.data,
    required this.textme,
  });
}

class onzek extends StatefulWidget {
  const onzek({super.key, required String title});

  @override
  State<onzek> createState() => _onzekState();
}

class _onzekState extends State<onzek> {
  List<Message> messages = [
    Message(
      text: 'hey marczer',
      data: DateTime.now().subtract(Duration(minutes: 1)),
      textme: false,
    ),
    Message(
      text: 'hey marc',
      data: DateTime.now().subtract(Duration(days: 2, minutes: 3)),
      textme: true,
    ),
    Message(
      text: 'ddd',
      data: DateTime.now().subtract(Duration(days: 2, minutes: 10)),
      textme: false,
    ),
  ].reversed.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(
                            title: '',
                          ),
                        ));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage("assets/images/lezer.jpeg"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Oula Marc",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.video_camera_front_outlined,
                  color: Colors.black54,
                ),
                Icon(
                  Icons.phone,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffe6f9ff),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text('hey marczer'),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        "10.00 PM",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xff41CDFB),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text('hey marc'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "10.00 PM",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.80,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffe6f9ff),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text('oui ndkw tu a fini de manger '),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        "10.00 PM",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Color(0xfff9f9f9),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffe6f9ff),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.photo_camera,
                              color: Colors.blueAccent),
                          onPressed: () {},
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.face,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {}),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xffe6f9ff),
                                hintText: "Message",
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.blueAccent),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Color(0xff41CDFB), shape: BoxShape.circle),
                  child: InkWell(
                    child: Icon(
                      Icons.keyboard_voice_outlined,
                      color: Colors.white,
                    ),
                    onLongPress: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 8),
        //   height: 70,
        //   color: Colors.white,
        //   child: Row(
        //     children: [
        //       IconButton(
        //         icon: Icon(Icons.photo),
        //         iconSize: 25,
        //         onPressed: () {},
        //       ),
        //       Expanded(
        //         child: TextField(
        //           decoration: InputDecoration.collapsed(
        //             hintText: "commencer a ecrit"
        //             ),
        //             textCapitalization: TextCapitalization.sentences,
        //         ),
        //       ),
        //       IconButton(
        //         icon: Icon(Icons.send),
        //         iconSize: 25,
        //         onPressed: () {},
        //       ),
        //     ]
        //   )

        //   )
      ]),
    );
  }
}

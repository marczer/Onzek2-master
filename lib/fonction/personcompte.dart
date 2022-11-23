import 'package:flutter/material.dart';
import 'package:onzek/screens/userpage/Settings/parametre.dart';

import '../screens/userpage/inbox.dart';

class personcompte extends StatefulWidget {
  final String image;
  final String username;
  final String lastmes;
  final String year;
  final String numbermes;

  const personcompte({
    super.key,
    required this.image,
    required this.username,
    required this.lastmes,
    required this.year,
    required this.numbermes,
  });
  @override
  State<personcompte> createState() => _personcompteState();
}

class _personcompteState extends State<personcompte> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => onzek(
                title: '',
              ),
            ));
      },
      child: Card(
        color: Color(0xffe6f9ff),
        // margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(widget.image),
          ),
          title: Text(widget.username),
          subtitle: Text(widget.lastmes),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(widget.year),
              Container(
                  height: 15,
                  width: 15,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color(0xff41CDFB),
                  ),
                  child: Center(
                    child: Text(widget.numbermes,
                        style: TextStyle(color: Colors.black)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class connectavata extends StatelessWidget {
  final String image;
  connectavata({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(image),
      ),
    );
    // Container(
    //            margin: EdgeInsets.all(5),
    //            height: 50,
    //            width: 50,
    //            decoration: BoxDecoration(
    //            borderRadius: BorderRadius.all(Radius.circular(30)),
    //            image: DecorationImage(image: AssetImage(image)),
    //            border: Border.all(
    //            width: 3,
    //            color: Colors.grey,
    //          )
    //       ),
    // );
  }
}

enum MenuItem {
  item1,
  item2,
}

class avata extends StatelessWidget {
  final String image;
  final String nom;
  final String prenom;
  avata({
    super.key,
    required this.image,
    required this.nom,
    required this.prenom,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(image),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nom),
            Text(prenom),
          ],
        ),
        SizedBox(
          width: 130,
        ),
        Icon(
          Icons.search,
          size: 30.0,
        ),
        PopupMenuButton(
          onSelected: (value) {
            if (value == MenuItem.item1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => para(),
                  ));
            }
          },
          icon: Icon(Icons.menu),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: MenuItem.item1,
              child: Text('Parametre'),
            ),
          ],
        ),
      ],
    );
  }
}

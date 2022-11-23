import 'package:flutter/material.dart';
import 'package:onzek/fonction/bouttons/boutton2.dart';
import 'package:onzek/fonction/bouttons/boutton1.dart';

import '../screens/registration/login.dart';

class Intro extends StatelessWidget {
  Intro(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.noOfScreen,
      required this.onNextPressed,
      required this.currentScreenNo})
      : super(key: key);

  final Image image;

  final String title;

  final String description;

  final int noOfScreen;

  final Function(int) onNextPressed;

  final int currentScreenNo;

  @override
  Widget build(BuildContext context) {
    bool isLastScreen = currentScreenNo >= noOfScreen - 1;
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 100),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 450, height: 150, child: image),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int index = 0; index < noOfScreen; index++)
                    pointsprogression((index == currentScreenNo) ? true : false)
                ],
              ),
              const SizedBox(height: 140),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0XFF333333),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
          Visibility(
            visible: !isLastScreen,
            replacement: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 50,
                    width: 300,
                    child: boutton2(title: "Commencer", onPressed: () {}))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                boutton1(
                    title: ("Passer"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => connection(),
                          ));
                    }),
                boutton2(
                  title: "Continuer",
                  onPressed: () {
                    onNextPressed(currentScreenNo + 1);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget pointsprogression(bool siecranactif) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: siecranactif ? 12 : 10,
      width: siecranactif ? 12 : 10,
      decoration: BoxDecoration(
          color: siecranactif ? Color(0XFF41cdfb) : Color(0xffceecf4),
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}

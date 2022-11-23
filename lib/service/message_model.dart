import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Message {
  late String from;
  late String to;
  late String text;
  late String dateString;
  late String imageUrl;

  Message(DataSnapshot snapshot) {
    from = snapshot.child("from").value.toString();
    to = snapshot.child("to").value.toString();
    text = snapshot.child("text").value.toString();
    dateString = snapshot.child("dateString").value.toString();
    imageUrl = snapshot.child("imageUrl").value.toString();
  }
}

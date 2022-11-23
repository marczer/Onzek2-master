import 'package:firebase_database/firebase_database.dart';
import 'package:onzek/service/usermodel.dart';

class Conversation {
  MyUser? user;
  String? date;
  String? msg;
  String? uid;
  Conversation(DataSnapshot snapshot) {
    user = MyUser(snapshot);
    uid = snapshot.child("monId").value.toString();
    msg = snapshot.child("lastMessage").value.toString();
    date = snapshot.child("dateString").value.toString();
  }
}

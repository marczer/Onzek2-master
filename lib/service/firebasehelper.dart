import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onzek/fonction/bouttons/snackbar.dart';
import 'package:onzek/service/usermodel.dart';

class FirebaseHelper {
  final auth = FirebaseAuth.instance;
  // final GoogleSignIn = GoogleSignIn

  //Authentification d'un user
  Future<User?> handleSignIn(String mail, String mdp) async {
    final User? user =
        (await auth.signInWithEmailAndPassword(email: mail, password: mdp))
            .user;
    return user;
  }

  Future<void> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');

        await auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );
          User? user = (await auth.signInWithCredential(credential)).user;

          String uid = user!.uid;
          Map<String, String> map = {
            "prenoms": user.displayName!,
            "nom": user.displayName!,
            "uid": uid,
            "imageUrl": user.photoURL!
          };
          addUser(uid, map);
          // if you want to do specific task like storing information in firestore
          // only for new users using google sign in (since there are no two options
          // for google sign in and google sign up, only one as of now),
          // do the following:

          // if (userCredential.user != null) {
          //   if (userCredential.additionalUserInfo!.isNewUser) {}
          // }
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      // showSnackBar( e.message!); // Displaying the error message
    }
  }

  Future<bool> handleLogOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
    return true;
  }

  //creation  d'un user
  Future<User> create(
      String mail, String mdp, String prenoms, String nom) async {
    final create =
        await auth.createUserWithEmailAndPassword(email: mail, password: mdp);
    final User? user = create.user;
    String uid = user!.uid;
    Map<String, String> map = {"prenoms": prenoms, "nom": nom, "uid": uid};
    addUser(uid, map);
    return user;
  }

  Future<bool> Resetpassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }
  // database

  // le point d'entré de la bd
  static final entryPoint = FirebaseDatabase.instance.ref();
  // le point d'entré de l'entité user
  static final userEntry = entryPoint.child("users");
  // le point d'entré de l'entité  message
  static final entryMessage = entryPoint.child("messages");
  // le point d'entré de l'entité  conversation
  static final entryConversation = entryPoint.child("conversations");
  //ajouter un user
  addUser(String uid, Map map) {
    userEntry.child(uid).set(map);
  }

  // obtenir user
  Future<MyUser> getUser(String uid) async {
    DatabaseEvent snapshot = (await userEntry.child(uid).once());
    MyUser user = MyUser(snapshot.snapshot);
    return user;
  }

  // envoyer sms dans la bd
  sendMessage(MyUser me, MyUser partenaire, String? texte, String? imageUrl) {
    //1=> ID1 + ID2
    String ref = getMessageRef(me.uid, partenaire.uid);
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    Map map = {
      "from": me.uid,
      "to": partenaire.uid,
      "text": texte,
      "dateString": date,
      "imageUrl": imageUrl
    };
    entryMessage.child(ref).child(date).set(map);

    //Notification de dernier message de conversation
    //on me notifie qu'une personne m'a ecrit
    entryConversation
        .child(me.uid)
        .child(partenaire.uid)
        .set(setConversation(partenaire, me.uid, texte!, date));
    //on notifie a une persone que je l'ai ecrit
    entryConversation
        .child(partenaire.uid)
        .child(me.uid)
        .set(setConversation(me, me.uid, texte, date));
  }

  //fonction pour recuperer le dernier sms
  Map setConversation(
      MyUser user, String sender, String last, String dateString) {
    //user, lastmessage , date
    Map map = user.toMap();
    map["monId"] = sender;
    map["lastMessage"] = last;
    map["dateString"] = dateString;
    map["monId"] = sender;
    return map;
  }

  //fonction qui prend la reference de celui qui envoie le sms en premier et fais "+" a la ref de celui qui l'envoie en second
  getMessageRef(from, to) {
    List<String> list = [from, to];
    list.sort((a, b) => a.compareTo(b));
    String ref = "";
    for (var x in list) {
      ref += x + "+";
    }
    return ref;
  }

  //storage
  static final entryStorage = FirebaseStorage.instance.ref();
  static final entryUser = entryStorage.child('users');
  static final entrySmS = entryStorage.child('messages');
  //obtenir imageQ
  static Future<String> savePic(File file, Reference reference) async {
    UploadTask task = reference.putFile(File(file.path));
    TaskSnapshot snap =
        await task.whenComplete(() => reference.getDownloadURL());
    Future<String> url = snap.ref.getDownloadURL();
    return url;
  }
}

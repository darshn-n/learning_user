// ignore_for_file: prefer_function_declarations_over_variables, avoid_print, invalid_return_type_for_catch_error, avoid_web_libraries_in_flutter

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsss_learning/screens/main_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  Future<void> addUser(context, uid) async {
    final QuerySnapshot result = await users.where('uid', isEqualTo: uid).get();

    List<DocumentSnapshot> document = result.docs;

    if (document.isNotEmpty) {
      Navigator.pushReplacementNamed(context, MainScreen.id);
    } else {
      return users.doc(user!.uid).set({
        'uid': user!.uid, // uid
        'email': user!.email,
        'address': null,
      }).then((value) {
        Navigator.pushReplacementNamed(context, MainScreen.id);
      }).catchError((error) => print("Failed to add user: $error"));
    }
  }

  // Call the user's CollectionReference to add a new user
}

// ignore_for_file: unnecessary_null_comparison

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/screens/login_screen.dart';
import 'package:gsss_learning/screens/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const String id = "splash-screen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var collection = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    Timer(
      const Duration(
        seconds: 3,
      ),
      () {
        FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {
            if (user == null) {
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            } else {
              Navigator.pushReplacementNamed(context, MainScreen.id);
            }
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white38,
      Colors.grey,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 15.0,
    );

    return Scaffold(
      backgroundColor: kscreenBackground,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/logo.png",
              width: 250,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 140,
              top: 720,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  'Version 2.0.0',
                  textStyle: colorizeTextStyle,
                  colors: colorizeColors,
                ),
              ],
              isRepeatingAnimation: true,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Made by Darshan",
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

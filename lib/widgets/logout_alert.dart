import 'package:animations/animations.dart';
import 'package:gsss_learning/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutAlert extends StatelessWidget {
  const LogoutAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showModal<String>(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(),
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text('Logout'),
            content: const Text('Are you sure, Do you want to logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF56EB5B),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then(
                        (value) => Navigator.of(context)
                            .pushNamedAndRemoveUntil(LoginScreen.id,
                                (Route<dynamic> route) => false),
                      );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xFFdc3545),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      child: const Text(
        "Logout",
        style: TextStyle(
            color: Color(0xFFdc3545),
            fontSize: 20,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}

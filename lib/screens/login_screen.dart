// ignore_for_file: use_build_context_synchronously

import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/screens/authentication/google_auth.dart';
import 'package:gsss_learning/services/phone_auth_services.dart';
import 'package:gsss_learning/widgets/alert_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_button/sign_button.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

final Uri _privacyPolicy = Uri.parse(
  "https://www.freeprivacypolicy.com/live/bcd8dbae-e617-4dec-aae6-c90e30b8b55f",
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = "login-screen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: const LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [
              kLoginBg2,
              kLoginBg2,
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 1.5 * screenWidth,
      height: 1.5 * screenWidth,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [
            kLoginBg2,
            kLoginBg2,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kLoginBg,
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: topWidget(screenSize.width),
          ),
          Positioned(
            bottom: -180,
            left: -40,
            child: bottomWidget(screenSize.width),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 30,
              top: 220,
            ),
            child: Image.asset(
              "assets/playstore.png",
              width: 300,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 45, right: 35),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        SignInButton(
                          btnText: "Continue with Google",
                          buttonSize: ButtonSize.large,
                          buttonType: ButtonType.google,
                          onPressed: () async {
                            showAlertDialog(context);
                            User? user =
                                await GoogleAuthentication.signInWithGoogle(
                                    context: context);
                            if (user != null) {
                              //Login Success
                              showAlertDialog(context);
                              PhoneAuthService auth = PhoneAuthService();
                              auth.addUser(context, user.uid);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "You'll be Logged in by accepting our",
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _launchUrl(
                              _privacyPolicy,
                            );
                          },
                          child: Text(
                            "Privacy Policy",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: kprivacyPolicy,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 85,
                        ),
                        Text(
                          " 1.0.0",
                          style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kprivacyPolicy,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Launch :

void _launchUrl(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gsss_learning/screens/test_screen.dart';
import 'package:gsss_learning/widgets/account_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsss_learning/widgets/logout_alert.dart';
import 'package:url_launcher/url_launcher.dart';

// final Uri _blogurl = Uri.parse('https://www.google.com/');
String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}


final Uri _reportBugs = Uri(
  scheme: 'mailto',
  path: 'darshan51081@gmail.com',
  query: encodeQueryParameters(
    <String, String>{
      'subject':
          'Bug Reporting by ${FirebaseAuth.instance.currentUser!.displayName}',
    },
  ),
);
final Uri _privacyPolicy = Uri.parse(
  "https://darshn-n.github.io/Privacy-Policy-Opportunes/",
);

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  static const String id = "account-screen";

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
        title: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Made by Darshan',
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          child: Text(
            'My Account',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                  left: 25,
                  right: 25,
                ),
              ),
              ClipOval(
                  child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${FirebaseAuth.instance.currentUser!.displayName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(
                      0xff050609,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FontAwesomeIcons.google,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${FirebaseAuth.instance.currentUser!.email}",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),

              
              AccountMenu(
                accountButtonIcon: Icons.help_center_outlined,
                accountButtonText: 'Help Center',
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ExampleScreen(),
                    ),
                  );
                },
              ),
              AccountMenu(
                accountButtonIcon: Icons.timer_outlined,
                accountButtonText: 'Upcoming Updates',
                onPressed: () {},
              ),
              AccountMenu(
                accountButtonIcon: Icons.verified_user_outlined,
                accountButtonText: 'Privacy Policy',
                onPressed: () {
                  _launchUrl(_privacyPolicy);
                },
              ),
              AccountMenu(
                accountButtonIcon: Icons.bug_report_outlined,
                accountButtonText: 'Report a Bug',
                onPressed: () {
                  _launchUrl(_reportBugs);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              const LogoutAlert(),
            ],
          ),
        ),
      ),
    );
  }
}

void _launchUrl(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

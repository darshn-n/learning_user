import 'package:gsss_learning/widgets/account_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

class AccountDropDown extends StatefulWidget {
  const AccountDropDown({super.key});

  @override
  State<AccountDropDown> createState() => _AccountDropDownState();
}

class _AccountDropDownState extends State<AccountDropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
                left: 25,
                right: 25,
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ClipOval(
              child: Image.network(
                FirebaseAuth.instance.currentUser!.photoURL!,
                width: 70,
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
            Text(
              "${FirebaseAuth.instance.currentUser!.email}",
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 30,
            ),
            // AccountMenu(
            //   accountButtonIcon: Icons.person_outline_outlined,
            //   accountButtonText: 'Help Center',
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const HelpCenter(),
            //       ),
            //     );
            //   },
            // ),
            // AccountMenu(
            //   accountButtonIcon: Icons.chat_outlined,
            //   accountButtonText: 'Our Blog',
            //   onPressed: () {
            //     _launchUrl(_blogurl);
            //   },
            // ),
            // ignore: todo
            //TODO: Add a button to report bugs
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
              height: 20,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text(
                'Edit Location and Personal Details',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}

// Launch :

void _launchUrl(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

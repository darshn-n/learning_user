// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountMenu extends StatelessWidget {
  const AccountMenu(
      {Key? key,
      required this.accountButtonText,
      required this.accountButtonIcon,
      required this.onPressed})
      : super(key: key);

  final String accountButtonText;
  final IconData accountButtonIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFFE8EAEF),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(
              15,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              accountButtonIcon,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                accountButtonText,
                style: GoogleFonts.roboto(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_outlined, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

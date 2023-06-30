  import 'package:flutter/material.dart';
  
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: const [
          CircularProgressIndicator(),
          SizedBox(
            width: 15.0,
          ),
          Text("Loading")
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
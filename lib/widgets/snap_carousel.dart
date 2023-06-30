import 'package:flutter/material.dart';

class SnapCarousel extends StatelessWidget {
  const SnapCarousel({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const <Widget>[
          
        ],
      ),
    );
  }
}

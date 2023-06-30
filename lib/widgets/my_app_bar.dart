import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Row(
        children: const [
          // Text(
          //   appbarName,
          //   style: TextStyle(
          //     color: Theme.of(context).primaryColor,
          //     fontSize: 20,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
        ],
      ),
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.purple,
      ),
    );
  }
}

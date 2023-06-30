// ignore_for_file: avoid_unnecessary_containers

import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategoryListScreen extends StatelessWidget {
  const SubCategoryListScreen({super.key});
  static const String id = "sub-category-list-screen";

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot args =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;
    FirebaseService service = FirebaseService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
        title: Text(
          args["catName"],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
          future: service.categories.doc(args.id).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: const CircularProgressIndicator(),
              );
            }

            var data = snapshot.data!["subCat"];

            return Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: ListTile(
                      onTap: () {},
                      title: Text(
                        data![index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

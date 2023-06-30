// ignore_for_file: avoid_unnecessary_containers

import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/providers/category_provider.dart';
import 'package:gsss_learning/screens/products_by_category.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectListByCatScreen extends StatelessWidget {
  const SubjectListByCatScreen({super.key, required this.sortID});

  static const String id = "subject-list-screen";
  final int sortID;

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    var catProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0.0,
        
        title: const Text(
          'Materials',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: service.categories
              .where(
                "sortID",
                isEqualTo: sortID,
              )
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Container();
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            }

            return Container(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  var doc = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: InkWell(
                      onTap: () {
                        // Products by Category
                        catProvider.getCategory(doc['catName']);
                        catProvider.getCatSnapshot(doc);
                        // Product by category
                        Navigator.pushNamed(
                          context,
                          ProductByCategory.id,
                          arguments: doc,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('assets/location_bg.jpg'),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    colors: [
                                      Colors.black.withOpacity(.4),
                                      Colors.black.withOpacity(.2),
                                    ],
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      doc['catName'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      height: 50,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 40),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Center(
                                          child: Text(
                                        "Check Out",
                                        style: TextStyle(
                                            color: Colors.grey[900],
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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

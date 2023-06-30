import 'package:gsss_learning/providers/category_provider.dart';
import 'package:gsss_learning/screens/categories/category_list.dart';
import 'package:gsss_learning/screens/products_by_category.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();

    var catProvider = Provider.of<CategoryProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<QuerySnapshot>(
        future: service.categories
            .where(
              "sortID",
              isEqualTo: 1,
            )
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 140.0,
                right: 140,
              ),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
                color: Colors.grey.shade100,
              ),
            );
          }

          return SizedBox(
            height: 130,
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text("Categories"),
                    ),
                    TextButton(
                      onPressed: () {
                        // Show all cats
                        Navigator.pushNamed(context, CategoryListScreen.id);
                      },
                      child: Row(
                        children: const [
                          Text(
                            'See All',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            size: 25,
                            color: Colors.cyan,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var doc = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            catProvider.getCategory(doc['catName']);
                            catProvider.getCatSnapshot(doc);
                            // Product by category
                            Navigator.pushNamed(
                              context,
                              ProductByCategory.id,
                              arguments: doc,
                            );
                          },
                          child: SizedBox(
                            width: 60,
                            height: 50,
                            child: Column(
                              children: [
                                Flexible(
                                  child: Text(
                                    // ignore: todo
                                    doc['catName'], // TODO: NFT
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

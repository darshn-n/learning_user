// ignore_for_file: depend_on_referenced_packages

import 'package:gsss_learning/providers/product_provider.dart';
import 'package:gsss_learning/screens/product_details_screen.dart';
import 'package:gsss_learning/screens/product_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:intl/intl.dart';

class Products {
  final String title, description, price, category;
  final DocumentSnapshot document;

  const Products({
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.document,
  });
}

class SearchService {
  search({context, productList, provider}) {
    showSearch(
      context: context,
      delegate: SearchPage<Products>(
          barTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xfffffeff),
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
          ),
          searchStyle: GoogleFonts.lato(
            fontSize: 20,
          ),
          onQueryUpdate: print,
          items: productList,
          searchLabel: 'Search Products',
          suggestion: const SingleChildScrollView(child: ProductList()),
          failure: Center(
            child: Image.asset("assets/sorrySearch.png"),
          ),
          filter: (product) => [
                product.title,
                product.description,
                product.category,
              ],
          builder: (product) {
            final format = NumberFormat("##,##,##0");
            var price = int.parse(product.document['price']);
            String formattedPrice = format.format(price);
            var provider = Provider.of<ProductProvider>(context);

            return InkWell(
              onTap: () {
                provider.getProductDetails(product.document);

                Navigator.pushNamed(context, ProductDetailsScreen.id);
              },
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 120,
                          child: Image.network(
                            product.document['images'][0],
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(product.title),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Text(
                                  formattedPrice,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );

            // ListTile(
            //         leading: Image.network(
            //           catProvider.dataToCloud["images"][0],
            //         ),
            //         title: Text(
            //           catProvider.dataToCloud['title'],
            //           maxLines: 1,
            //         ),
            //         subtitle: Text(
            //           catProvider.dataToCloud['price'],
            //           maxLines: 1,
            //         ),
            //       ),
          }),
    );
  }
}

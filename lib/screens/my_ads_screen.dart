// ignore_for_file: depend_on_referenced_packages

import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:gsss_learning/widgets/product_display_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});
  static const String id = "ads-screen";

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    final format = NumberFormat("##,##,##0");

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: kscreenBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kscreenBackground,
          elevation: 0.0,
          title: Text(
            'My Ads',
            style: GoogleFonts.raleway(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            indicatorWeight: 3,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                child: Text(
                  'ADS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Favourites',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  8,
                  12,
                  8,
                ),
                child: FutureBuilder<QuerySnapshot>(
                  future: service.products
                      .where("sellerUid", isEqualTo: service.user!.uid)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                        'Something went wrong',
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 140.0,
                          right: 140.0,
                        ),
                        child: Center(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                            color: Colors.grey.shade100,
                          ),
                        ),
                      );
                    }

                    if (snapshot.data!.docs.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 56,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'My Recent Posts',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              // shrinkWrap: true,
                              // physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: snapshot.data!.size,
                              itemBuilder: (BuildContext context, int index) {
                                var data = snapshot.data!.docs[index];
                                var price = int.parse(data['price']);
                                String formattedPrice = format.format(price);

                                // Display Card:
                                return ProductDisplayCard(
                                    data: data, formattedPrice: formattedPrice);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'No Ads Posted yet',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  8,
                  12,
                  8,
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: service.products
                      .where("favourites", arrayContains: service.user!.uid).snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                        'Something went wrong',
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 140.0,
                          right: 140.0,
                        ),
                        child: Center(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor,
                            ),
                            color: Colors.grey.shade100,
                          ),
                        ),
                      );
                    }

                    if (snapshot.data!.docs.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 56,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'My Favourites',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              // shrinkWrap: true,
                              // physics: const ScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 2 / 2.8,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: snapshot.data!.size,
                              itemBuilder: (BuildContext context, int index) {
                                var data = snapshot.data!.docs[index];
                                var price = int.parse(data['price']);
                                String formattedPrice = format.format(price);

                                // Display Card:
                                return ProductDisplayCard(
                                    data: data, formattedPrice: formattedPrice);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          'Your Favourite list is Empty :(',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

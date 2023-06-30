// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/providers/product_provider.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:gsss_learning/widgets/account_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _reportAd = Uri(
  scheme: 'mailto',
  path: 'darshan51081@gmail.com',
  query: encodeQueryParameters(
    <String, String>{
      'subject':
          'Inappropriate Ad Reporting by ${FirebaseAuth.instance.currentUser!.displayName}',
    },
  ),
);

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String id = "product-details-screen";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  FirebaseService service = FirebaseService();
  bool _loading = true;
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
      () {
        setState(() {
          _loading = false;
        });
      },
    );
    super.initState();
  }

  int _index = 0;

  List favs = [];
  bool isLiked = false;


  @override
  void didChangeDependencies() {
    var productProvider = Provider.of<ProductProvider>(context);

    getFavourites(productProvider);
    super.didChangeDependencies();
  }

  getFavourites(ProductProvider productProvider) {
    service.products.doc(productProvider.productData.id).get().then((value) {
      setState(() {
        favs = value['favourites'];
      });
      if (favs.contains(service.user!.uid)) {
        setState(() {
          isLiked = true;
        });
      } else {
        setState(
          () {
            isLiked = false;
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var data = productProvider.productData;

    final format = NumberFormat("##,##,##0");
    var price = int.parse(
      data['price'],
    );
    String formattedPrice = format.format(price);

    _makingPhoneCall() async {
      var url = Uri.parse("tel: ");
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Product Details",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.share_outlined,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
              service.upDateFavourite(
                isLiked,
                data.id,
                context,
              );
            },
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
            ),
            color: isLiked ? Colors.red : Colors.grey,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300.0,
                color: Colors.grey.shade300,
                child: _loading
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
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
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              'Loading ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: PhotoView(
                          backgroundDecoration: BoxDecoration(
                            color: Colors.grey.shade300,
                          ),
                          imageProvider: NetworkImage(
                            data['images'][_index],
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              if (_loading == false)
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: ListView.builder(
                      itemExtent: 70,
                      scrollDirection: Axis.horizontal,
                      itemCount: data['images'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _index = index;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black26,
                              ),
                            ),
                            child: Image.network(
                              data['images'][index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              _loading
                  ? Padding(
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
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                data["title"].toUpperCase(),
                                style: GoogleFonts.raleway(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "(${data['year']})",
                            style: GoogleFonts.abel(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xffe4e4e4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0, // soften the shadow
                                    spreadRadius: 3.0, //extend the shadow
                                    offset: Offset(
                                      5.0, // Move to right 5  horizontally
                                      5.0, // Move to bottom 5 Vertically
                                    ),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Price',
                                          style: GoogleFonts.raleway(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " : $formattedPrice",
                                          style: GoogleFonts.abel(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Previous Owners',
                                          style: GoogleFonts.raleway(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " : ${data['owner']}",
                                          style: GoogleFonts.abel(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Owner Address : ',
                                          style: GoogleFonts.raleway(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            " Near ${data['landmark']}, ${data['address']}",
                                            maxLines: 10,
                                            style: GoogleFonts.raleway(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Category',
                                          style: GoogleFonts.raleway(
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          " : ${data['category']}",
                                          style: GoogleFonts.raleway(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Additional Description : ',
                          style: GoogleFonts.raleway(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Text(
                              data['description'],
                              maxLines: 50,
                              style: GoogleFonts.raleway(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  _launchUrl(_reportAd);
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Icon(
                        Icons.bug_report_outlined,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        'Report this Ad',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 70.0,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Row(
        children: [
          productProvider.productData['sellerUid'] == service.user!.uid
              ? Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // ignore: todo
                        // TODO: Edit.
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.edit_outlined,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Edit Product',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _makingPhoneCall();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.phone_outlined,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Call',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          const SizedBox(
            width: 5.0,
          ),
          // if (productProvider.productData['sellerUid'] != service.user!.uid)
        ],
      ),
    );
  }
}

void _launchUrl(url) async {
  if (!await launchUrl(url)) throw 'Could not launch $url';
}

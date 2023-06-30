// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:gsss_learning/providers/product_provider.dart';
import 'package:gsss_learning/screens/product_details_screen.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDisplayCard extends StatefulWidget {
  const ProductDisplayCard({
    Key? key,
    required this.data,
    required this.formattedPrice,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;
  final String formattedPrice;

  @override
  State<ProductDisplayCard> createState() => _ProductDisplayCardState();
}

class _ProductDisplayCardState extends State<ProductDisplayCard> {
  FirebaseService service = FirebaseService();

  final format = NumberFormat("##,##,##0");
  List favs = [];
  bool isLiked = false;

  @override
  void initState() {
    getFavourites();
    super.initState();
  }

  getFavourites() {
    service.products.doc(widget.data.id).get().then((value) {
      if (mounted) {
        setState(
          () {
            favs = value['favourites'];
          },
        );
      }
      if (favs.contains(service.user!.uid)) {
        if (mounted) {
          setState(() {
            isLiked = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isLiked = false;
          });
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: () {
        provider.getProductDetails(widget.data);
        Navigator.pushNamed(context, ProductDetailsScreen.id);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: BorderRadius.circular(
            4,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: Image.network(
                        widget.data['images'][0],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Price:
                  Text(
                    widget.data['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Price : ${widget.formattedPrice}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "Previous Owners : ${widget.data['owner']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0.0,
                
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    service.upDateFavourite(
                      isLiked,
                      widget.data.id,
                      context,
                    );
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: isLiked ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

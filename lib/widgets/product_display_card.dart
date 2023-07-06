// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'package:gsss_learning/providers/product_provider.dart';
import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDisplayCard extends StatefulWidget {
  const ProductDisplayCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  State<ProductDisplayCard> createState() => _ProductDisplayCardState();
}

class _ProductDisplayCardState extends State<ProductDisplayCard> {
  FirebaseService service = FirebaseService();


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return InkWell(
      onTap: () {
        provider.getProductDetails(widget.data);
      },
      child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [

              // Tile name
              Text(
                widget.data['text'],
                maxLines: 1, // Don't wrap at all
                softWrap: false, // Don't wrap at soft breaks
                overflow: TextOverflow.ellipsis, // Clip the overflow
              ),
              const Spacer(),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.keyboard_arrow_left_outlined,
                ),
              )
            ],
          ),
        ),
    );
  }
}

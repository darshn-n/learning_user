import 'package:gsss_learning/constants/colors.dart';
import 'package:gsss_learning/providers/category_provider.dart';
import 'package:gsss_learning/screens/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductByCategory extends StatelessWidget {
  const ProductByCategory({super.key});
  static const String id = "product-by-category-screen";

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);

    return Scaffold(
      backgroundColor: kscreenBackground,
      appBar: AppBar(
        backgroundColor: kscreenBackground,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black54,
        ),
        title: Text(
          catProvider.selectedCategory.toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: const SingleChildScrollView(child: ProductList())
    );
  }
}

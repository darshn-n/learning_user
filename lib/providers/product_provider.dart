import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductProvider with ChangeNotifier {
  late DocumentSnapshot productData;
  DocumentSnapshot? sellerData;
  getProductDetails(details) {
    productData = details;
    notifyListeners();
  }

  getSellerDetails(sellerDetails) {
    sellerData = sellerDetails;
    notifyListeners();
  }
}

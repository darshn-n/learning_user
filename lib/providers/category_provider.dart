import 'package:gsss_learning/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  late DocumentSnapshot doc;
  late DocumentSnapshot userDetails;
  String? selectedCategory;
  late List<String> urlList = [];
  Map<String, dynamic> dataToCloud = {};

  getCategory(selectedCategory) {
    this.selectedCategory = selectedCategory;
    notifyListeners();
  }

  getCatSnapshot(snapshot) {
    doc = snapshot;
    notifyListeners();
  }

  getImages(url) {
    urlList.add(url);
    notifyListeners();
  }

  getData(data) {
    dataToCloud = data;
    notifyListeners();
  }

  getUserData() {
    _service.getUserData().then((value) {
      userDetails = value;
      notifyListeners();
    });
  }

  clearData() {
    urlList = [];
    dataToCloud = {};
    notifyListeners();
  }
}

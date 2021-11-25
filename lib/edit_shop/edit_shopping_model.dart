import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping/domain/shopping.dart';

class EditShoppingModel extends ChangeNotifier {
  final Shopping shopping;
  EditShoppingModel(this.shopping) {
    titleController.text = shopping.title;
    priceController.text = shopping.price;
  }

  final titleController = TextEditingController();
  final priceController = TextEditingController();

  String? title;
  String? price;

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setPrice(String price) {
    this.price = price;
    notifyListeners();
  }

  bool isUpdated() {
    return title != null || price != null;
  }

  Future update() async {
    this.title = titleController.text;
    this.price = priceController.text;

    await FirebaseFirestore.instance
        .collection('shops')
        .doc(shopping.id)
        .update({
      'title': title,
      'price': price,
    });
  }
}

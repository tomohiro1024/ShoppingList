import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddShoppingModel extends ChangeNotifier {
  String? title;
  String? price;

  Future addshopping() async {
    if (title == null || title == "") {
      throw '商品名が入力されていません';
    }

    if (price == null || price!.isEmpty) {
      throw '価格が入力されていません';
    }

    await FirebaseFirestore.instance.collection('shops').add({
      'title': title,
      'price': price,
    });
  }
}

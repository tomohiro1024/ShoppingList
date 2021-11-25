import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping/domain/shopping.dart';

class ShoppingListModel extends ChangeNotifier {
  List<Shopping>? shops;

  void fetchShoppingList() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shops').get();
    final List<Shopping> shops = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String price = data['price'];
      return Shopping(id, title, price);
    }).toList();

    this.shops = shops;
    notifyListeners();
  }
}

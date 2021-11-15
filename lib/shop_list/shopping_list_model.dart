import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping/domain/shopping.dart';

class ShoppingListModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('shops').snapshots();

  List<Shopping>? shops;

  void fetchShoppingList() {
    _usersStream.listen((QuerySnapshot snapshot) {
      final List<Shopping> shops =
          snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String title = data['title'];
        final String price = data['price'];
        return Shopping(title, price);
      }).toList();
      this.shops = shops;
      notifyListeners();
    });
  }
}

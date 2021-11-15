import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping/shopping_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shoppingList',
      home: ShoppingListPage(),
    );
  }
}

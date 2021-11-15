import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/domain/shopping.dart';
import 'package:shopping/shop_list/shopping_list_model.dart';

class ShoppingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListModel>(
      create: (_) => ShoppingListModel()..fetchShoppingList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('買い物リスト'),
        ),
        body: Center(
          child: Consumer<ShoppingListModel>(builder: (context, model, child) {
            final List<Shopping>? shops = model.shops;

            if (shops == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = shops
                .map(
                  (shopping) => ListTile(
                    title: Text(shopping.title),
                    subtitle: Text(shopping.price),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

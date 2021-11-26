import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/add_shop/add_shopping_page.dart';
import 'package:shopping/domain/shopping.dart';
import 'package:shopping/edit_shop/edit_shopping_page.dart';
import 'package:shopping/shop_list/shopping_list_model.dart';

class ShoppingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ShoppingListModel>(
      create: (_) => ShoppingListModel()..fetchShoppingList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('買い物リスト'),
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Consumer<ShoppingListModel>(builder: (context, model, child) {
            final List<Shopping>? shops = model.shops;

            if (shops == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = shops
                .map(
                  (shopping) => Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.green),
                      ),
                    ),
                    child: ListTile(
                        title: Text(shopping.title),
                        subtitle: Text(shopping.price + '円'),
                        onTap: () async {
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditShoppingPage(shopping),
                            ),
                          );

                          if (title != null) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('$titleを編集しました'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          model.fetchShoppingList();
                        },
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        )),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<ShoppingListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddShoppingPage(),
                  fullscreenDialog: true,
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text('追加しました'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchShoppingList();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          );
        }),
      ),
    );
  }
}

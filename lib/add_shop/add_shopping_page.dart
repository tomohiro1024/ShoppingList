import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/add_shop/add_shopping_model.dart';

class AddShoppingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddShoppingModel>(
      create: (_) => AddShoppingModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('商品の追加'),
        ),
        body: Center(
          child: Consumer<AddShoppingModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: '商品名',
                    ),
                    onChanged: (text) {
                      model.title = text;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '価格',
                    ),
                    onChanged: (text) {
                      model.price = text;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await model.addshopping();
                        Navigator.of(context).pop(true);
                      } catch (e) {
                        final snackBar = SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text('追加する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

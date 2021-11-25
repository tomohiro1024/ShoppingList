import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/domain/shopping.dart';

import 'edit_shopping_model.dart';

class EditShoppingPage extends StatelessWidget {
  //リストページから引数を受け取る場所
  final Shopping shopping;
  EditShoppingPage(this.shopping);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditShoppingModel>(
      create: (_) => EditShoppingModel(shopping),
      child: Scaffold(
        appBar: AppBar(
          title: Text('商品の編集'),
          backgroundColor: Colors.pink,
        ),
        body: Center(
          child: Consumer<EditShoppingModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.titleController,
                    decoration: InputDecoration(
                      hintText: '商品名',
                    ),
                    onChanged: (text) {
                      model.setTitle(text);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: model.priceController,
                    decoration: InputDecoration(
                      hintText: '価格',
                    ),
                    onChanged: (text) {
                      model.setPrice(text);
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            try {
                              await model.update();
                              Navigator.of(context).pop(model.title);
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: Text('更新する'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
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

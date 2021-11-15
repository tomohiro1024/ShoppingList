import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShoppingListPage extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('shops').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('買い物リスト'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['title']),
                  subtitle: Text(data['price']),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'products.dart';

class ProductDetails extends StatelessWidget {
  final String id;

  ProductDetails(this.id);

  @override
  Widget build(BuildContext context) {
    List<Product> prodList = Provider.of<Products>(context, listen: true).productsList;

    var filteredItem = prodList.firstWhere((element) => element.id == id);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: filteredItem == null ? null : Text(filteredItem.title),
          actions: [
            FlatButton(onPressed: ()=> Provider.of<Products>(context, listen: false).updateData(id), child: Text("Update Data"))
          ],
      ),
      body: filteredItem == null
          ? null
          : ListView(
              children: [
                SizedBox(height: 10),
                buildContainer(filteredItem.imageUrl, filteredItem.id),
                SizedBox(height: 10),
                buildCard(filteredItem.title, filteredItem.description,
                    filteredItem.price),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.pop(context, filteredItem.id);
        },
        child: Icon(Icons.delete, color: Colors.black),
      ),
    );
  }

  Container buildContainer(String image, String id) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Hero(
          tag: id,
          child: Image.network(image),
        ),
      ),
    );
  }

  Card buildCard(String title, String desc, double price) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Divider(color: Colors.black),
            Text(desc,
                style: TextStyle(fontSize: 16), textAlign: TextAlign.justify),
            Divider(color: Colors.black),
            Text(
              "\$$price",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'products.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String title = "";
  String description = "";
  String price = "";
  String imageUrl = "";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
          backgroundColor: Colors.blueGrey
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Title", hintText: "Add title"),
                    onChanged: (val) => setState(() => title = val),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Description", hintText: "Add description"),
                    onChanged: (val) => setState(() => description = val),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Price", hintText: "Add price"),
                    onChanged: (val) => setState(() => price = val),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Image Url",
                        hintText: "Paste your image url here"),
                    onChanged: (val) => setState(() => imageUrl = val),
                  ),
                  SizedBox(height: 30),
                  Consumer<Products>(
                    builder: (ctx, value, _) => RaisedButton(
                        color: Colors.orangeAccent,
                        textColor: Colors.black,
                        child: Text("Add Product"),
                        onPressed: () {
                          var doublePrice;
                          setState(() {
                            doublePrice = double.tryParse(price) ?? 0.0;
                          });

                          if (title == "" ||
                              description == "" ||
                              price == "" ||
                              imageUrl == "") {
                            Toast.show("Please enter all field", context,
                                duration: Toast.LENGTH_LONG);
                          } else if (doublePrice == 0.0) {
                            Toast.show("Please enter a valid price", context,
                                duration: Toast.LENGTH_LONG);
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            value
                                .add(
                              id: DateTime.now().toString(),
                              title: title,
                              description: description,
                              price: doublePrice,
                              imageUrl: imageUrl,
                            )
                                .catchError((_) {
                              return showDialog<Null>(
                                context: context,
                                builder: (innerContext) => AlertDialog(
                                  title: Text("An error occurred!"),
                                  content: Text('Something went wrong.'),
                                  actions: [
                                    FlatButton(
                                        child: Text("Okay"),
                                        onPressed: () =>
                                            Navigator.of(innerContext).pop())
                                  ],
                                ),
                              );
                            }).then((_) {
                              setState(() {
                                _isLoading = false;
                              });
                              Navigator.pop(context);
                            });
                          }
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';

class ShoppingCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Cart();
  }
}

class Cart extends State<ShoppingCart> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Shopping Cart'),
      ),
      body: Text("Shopping Cart"),
    );
  }
}

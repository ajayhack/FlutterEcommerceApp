import 'package:flutter/material.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ShoppingCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Cart();
  }
}

class Cart extends State<ShoppingCart> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  final scrollController = ScrollController();
  var shoppingCartData;
  bool dataLoadStatus = false;

  @override
  void initState() {
    super.initState();
    getCartData();
  }

  //Below method is used to retrieve shopping cart data from DB:-
  getCartData() async {
    var cartCount = await dbHelper.addedProductToCartCount();
    print('Shopping Cart Products: $cartCount');
    shoppingCartData = dbHelper.queryAllShoppingCartRows();
    setState(() {
      shoppingCartData = shoppingCartData;
      dataLoadStatus = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        backgroundColor: Colors.green,
        title: Text('Shopping Cart'),
      ),
      body: getProductsList(),
    );
  }

  //Below method is used to show Cart Added Data List:-
  getProductsList() {
    if (dataLoadStatus) {
      return ListView.builder(
        controller: scrollController,
        itemCount: shoppingCartData.length,
        itemBuilder: (BuildContext context, int index) {
          return new Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              color: Colors.blue,
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  Image.asset(
                      'assets/images/daily_essentials_images/dailyBannerOne.jpg'),
                  Text(
                    'Product Serial No.: ' +
                        shoppingCartData[index]["productSerialNumber"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Title: ' + shoppingCartData[index]["productTitle"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Mrp: ' +
                        '\u20B9' +
                        shoppingCartData[index]["productMrp"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Discount: ' +
                        '\u20B9' +
                        shoppingCartData[index]["productDiscount"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Price: ' +
                        '\u20B9' +
                        shoppingCartData[index]["productPrice"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.orange,
                          onPressed: () {},
                          child: Text(
                            'Add to Cart',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 16.0, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.red,
                          onPressed: () {},
                          child: Text(
                            'Add to Favorites',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 16.0, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                        child: RaisedButton(
                          padding: EdgeInsets.all(8.0),
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () {},
                          child: Text(
                            'Shop Now',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 14.0, fontStyle: FontStyle.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      Text("No Data Found");
    }
  }
}

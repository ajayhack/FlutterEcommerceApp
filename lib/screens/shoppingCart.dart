import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ShoppingCart extends StatefulWidget {
  final List<Map<String, dynamic>> cartData;

  ShoppingCart({Key key, @required this.cartData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Cart(cartData);
  }
}

class Cart extends State<ShoppingCart> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  final scrollController = ScrollController();
  var shoppingCartData;

  Cart(List<Map<String, dynamic>> cartData) {
    shoppingCartData = cartData;
    print('Cart Data:- $cartData');
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
    if (shoppingCartData.length > 0) {
      return Stack(children: [
        ListView.builder(
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
                          shoppingCartData[index]["productMrp"].toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    Text(
                      'Product Discount: ' +
                          '\u20B9' +
                          shoppingCartData[index]["productDiscount"].toString(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    Text(
                      'Product Price: ' +
                          '\u20B9' +
                          shoppingCartData[index]["productPrice"].toString(),
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
                            onPressed: () {
                              addToFav(shoppingCartData[index], 1,
                                  "Product Add To Favourites Successfully");
                            },
                            child: Text(
                              'Add to Favorites',
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
                            onPressed: () {
                              deleteProduct(
                                  shoppingCartData[index]["productId"]);
                            },
                            child: Text(
                              'Delete Product',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 16.0, fontStyle: FontStyle.normal),
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
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            width: double.infinity,
            child: FlatButton(
              child: Text('Order Now', style: TextStyle(fontSize: 24)),
              onPressed: () => {},
              color: Colors.green,
              textColor: Colors.white,
            ),
          ),
        ),
      ]);
    } else {
      return Center(
          child: FittedBox(
        child: Image.asset("assets/images/animated_images/cart_empty.gif"),
        fit: BoxFit.fill,
      ));
    }
  }

  //Below method is used to save Cart Data in Favourites DB:-
  addToFav(Map<String, dynamic> modal, int favourite, String successMSG) async {
    var dateTime = DateTime.now();
    Map<String, dynamic> cart = {
      DatabaseHelper.productId: dateTime.year +
          dateTime.month +
          dateTime.day +
          dateTime.hour +
          dateTime.minute +
          dateTime.second,
      DatabaseHelper.productSerialNumber: modal["productSerialNumber"],
      DatabaseHelper.productTitle: modal["productTitle"],
      DatabaseHelper.productMrp: modal["productMrp"],
      DatabaseHelper.productDiscount: modal["productDiscount"],
      DatabaseHelper.productPrice: modal["productPrice"],
      DatabaseHelper.isFavourite: favourite
    };

    final updatedToFav = await dbHelper.updateToFav(cart);
    if (updatedToFav > 0) {
      print("Favourite Added Success: $updatedToFav");
      successToast(successMSG, Colors.green, Colors.white);
      dbHelper.queryAllShoppingCartRows().then(
            (value) => setState(() {
              shoppingCartData = value;
            }),
          );
      /*Future.delayed(Duration(seconds: 1), () {
        navigateScreen(DashboardScreen());
      });*/
    } else {
      print("Favourite Added Failed: $updatedToFav");
      successToast(
          "Failed to Add Product to Favourites", Colors.red, Colors.white);
    }
  }

  //Below method is used to delete product from cart:-
  deleteProduct(String productId) {
    dbHelper
        .deleteCartItem(productId)
        .then((value) => successToast(
            "Product sNo. $productId Deleted Successfully",
            Colors.blue,
            Colors.white))
        .then((value) =>
            dbHelper.queryAllShoppingCartRows().then((value) => setState(() {
                  shoppingCartData = value;
                })));
  }

  //Below method is used to handle navigate screen:-
  navigateScreen(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  //Toast Message in App:-
  successToast(
      String validMsg, Color validBackGroundColor, Color validTextColor) {
    Fluttertoast.showToast(
        msg: validMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: validBackGroundColor,
        textColor: validTextColor,
        fontSize: 16.0);
  }
}

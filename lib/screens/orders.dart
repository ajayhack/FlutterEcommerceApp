import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class Orders extends StatefulWidget {
  final List<Map<String, dynamic>> orderData;

  Orders({Key key, @required this.orderData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return OrdersList(orderData);
  }
}

class OrdersList extends State<Orders> {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  final scrollController = ScrollController();
  var orderDataList;

  OrdersList(List<Map<String, dynamic>> orderData) {
    orderDataList = orderData;
    print('Favourite Data:- $orderDataList');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        backgroundColor: Colors.green,
        title: Text('My Orders'),
      ),
      body: getProductsList(),
    );
  }

  //Below method is used to show Cart Added Data List:-
  getProductsList() {
    if (orderDataList.length > 0) {
      return ListView.builder(
        controller: scrollController,
        itemCount: orderDataList.length,
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
                        orderDataList[index]["productSerialNumber"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Title: ' + orderDataList[index]["productTitle"],
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Mrp: ' +
                        '\u20B9' +
                        orderDataList[index]["productMrp"].toString(),
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Discount: ' +
                        '\u20B9' +
                        orderDataList[index]["productDiscount"].toString(),
                    style: TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.white),
                  ),
                  Text(
                    'Product Price: ' +
                        '\u20B9' +
                        orderDataList[index]["productPrice"].toString(),
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
                            addToCart(orderDataList[index], 0,
                                "Product Add To Cart Successfully");
                          },
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
                          onPressed: () {
                            deleteProduct(orderDataList[index]["productId"]);
                          },
                          child: Text(
                            'Cancel Order',
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
      );
    } else {
      return Center(
          child: FittedBox(
        child: Image.asset("assets/images/animated_images/cart_empty.gif"),
        fit: BoxFit.fill,
      ));
    }
  }

  //Below method is used to save Cart Data in Favourites DB:-
  addToCart(
      Map<String, dynamic> modal, int cartStatus, String successMSG) async {
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
      DatabaseHelper.isFavourite: cartStatus
    };

    final updatedToCart = await dbHelper.updateToFav(cart);
    if (updatedToCart > 0) {
      print("Cart Added Success: $updatedToCart");
      successToast(successMSG, Colors.green, Colors.white);
      dbHelper.queryAllOrdersRows().then(
            (value) => setState(() {
              orderDataList = value;
            }),
          );
    } else {
      print("Cart Added Failed: $updatedToCart");
      successToast(
          "Failed to Add Product to Favourites", Colors.red, Colors.white);
    }
  }

  //Below method is used to delete product from cart:-
  deleteProduct(String productId) {
    dbHelper
        .deleteCartItem(productId)
        .then((value) => successToast(
            "Product sNo. $productId Order Canceled Successfully",
            Colors.blue,
            Colors.white))
        .then((value) =>
            dbHelper.queryAllOrdersRows().then((value) => setState(() {
                  orderDataList = value;
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

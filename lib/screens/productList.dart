import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:indian_ecommerce_app/models/productListModal.dart';
import 'package:indian_ecommerce_app/screens/dashboard.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ProductList extends StatefulWidget {
  final String subCategory;

  ProductList({Key key, @required this.subCategory}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Products(subCategory);
  }
}

class Products extends State<ProductList> {
  String subCategoryName;
  final scrollController = ScrollController();
  List<ProductListModal> productDataList = List<ProductListModal>();

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  Products(String subCategory) {
    log('data: $subCategory');
    subCategoryName = subCategory;

    //Here we are adding Dummy Data into ProductList:-
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Milk',
        '25',
        '5',
        '20',
        'DE001'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Honey',
        '250',
        '50',
        '200',
        'DE002'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Parle G',
        '5',
        '1',
        '4',
        'DE003'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Namkeen',
        '10',
        '2',
        '8',
        'DE004'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Oats',
        '180',
        '25',
        '155',
        'DE005'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Coffee',
        '140',
        '20',
        '120',
        'DE006'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Curd',
        '30',
        '5',
        '25',
        'DE007'));
    productDataList.add(ProductListModal(
        'assets/images/daily_essentials_images/dailyBannerOne.jpg',
        'Choclate',
        '80',
        '15',
        '60',
        'DE008'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        backgroundColor: Colors.green,
        title: Text('Products'),
      ),
      body: getProductsList(subCategoryName),
    );
  }

  //Below method is used to show Products List:-
  getProductsList(String subCategoryName) {
    return ListView.builder(
      controller: scrollController,
      itemCount: productDataList.length,
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
                  'Product Serial No.: ' + productDataList[index].productNumber,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                Text(
                  'Product Title: ' + productDataList[index].productName,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                Text(
                  'Product Mrp: ' +
                      '\u20B9' +
                      productDataList[index].productMRP,
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                Text(
                  'Product Discount: ' +
                      '\u20B9' +
                      productDataList[index].productDiscount,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                Text(
                  'Product Price: ' +
                      '\u20B9' +
                      productDataList[index].productFinalPrice,
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
                          addToCart(productDataList[index], 0,
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
                          addToCart(productDataList[index], 1,
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
                      padding: EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                      child: RaisedButton(
                        padding: EdgeInsets.all(8.0),
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {
                          addToCart(productDataList[index], 2,
                              "Product Add To Shop Now Successfully");
                        },
                        child: Text(
                          'Order Now',
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
  }

  //Below method is used to save Cart Data in DB:-
  addToCart(ProductListModal modal, int favourite, String successMSG) async {
    var dateTime = DateTime.now();
    Map<String, dynamic> cart = {
      DatabaseHelper.productId: dateTime.year +
          dateTime.month +
          dateTime.day +
          dateTime.hour +
          dateTime.minute +
          dateTime.second,
      DatabaseHelper.productSerialNumber: modal.productNumber,
      DatabaseHelper.productTitle: modal.productName,
      DatabaseHelper.productMrp: modal.productMRP,
      DatabaseHelper.productDiscount: modal.productDiscount,
      DatabaseHelper.productPrice: modal.productFinalPrice,
      DatabaseHelper.isFavourite: favourite
    };

    final addedToCart = await dbHelper.insertAddToCartData(cart);
    if (addedToCart > 0) {
      print("Cart Success: $addedToCart");
      addCartSuccessToast(successMSG, Colors.green, Colors.white);
      Future.delayed(Duration(seconds: 1), () {
        navigateScreen(DashboardScreen());
      });
    } else {
      print("Cart Success: $addedToCart");
      addCartSuccessToast(
          "Failed to Add Product to Cart", Colors.red, Colors.white);
    }
  }

  //Below method is used to handle navigate screen:-
  navigateScreen(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  //Toast Message in App:-
  addCartSuccessToast(
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

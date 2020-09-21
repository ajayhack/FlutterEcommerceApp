import 'dart:developer';

import 'package:indian_ecommerce_app/models/productListModal.dart';
import 'package:flutter/material.dart';

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
  List<ProductListModal> productDataList = List<ProductListModal>();

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
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Products'),
      ),
      body: getProductsGridList(subCategoryName),
    );
  }

  getProductsGridList(String subCategoryName) {
    return ListView.builder(
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
  }
}

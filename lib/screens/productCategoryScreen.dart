import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:indian_ecommerce_app/screens/productList.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

class ProductCategoryScreen extends StatefulWidget {
  final String isExpanded;

  ProductCategoryScreen({Key key, @required this.isExpanded}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductCategoryExpandedList(isExpanded);
  }
}

class ProductCategoryExpandedList extends State<ProductCategoryScreen> {
  //Below Boolean Values to determine which Expansion Tile is needed to be expanded when user clicks through Dashboard:-
  bool isDailyEssential = false;
  bool isElectronics = false;
  bool isHealthAndFitness = false;
  bool isLifeStyle = false;
  bool isMedicine = false;
  bool isMenClothing = false;
  bool isWomenClothing = false;
  final scrollController = ScrollController();

  ProductCategoryExpandedList(String isExpanded) {
    log('data: $isExpanded');
    switch (isExpanded) {
      case 'DE':
        {
          isDailyEssential = true;
        }
        break;

      case 'EE':
        {
          isElectronics = true;
        }
        break;

      case 'HF':
        {
          isHealthAndFitness = true;
        }
        break;

      case 'LS':
        {
          isLifeStyle = true;
        }
        break;

      case 'ME':
        {
          isMedicine = true;
        }
        break;

      case 'MC':
        {
          isMenClothing = true;
        }
        break;

      case 'WC':
        {
          isWomenClothing = true;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: scrollController,
        backgroundColor: Colors.green,
        title: Text('Products Categories'),
      ),
      body: getProductExpandedList(),
    );
  }

  getProductExpandedList() {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isDailyEssential,
                title: Text("Daily Essentials "),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('DE001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Dairy Fresh',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('DE002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Daily Grocery',
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('DE003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Fresh Vegetables',
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('DE004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Fresh Fruits',
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isElectronics,
                title: Text("Electronic Products "),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('EE001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Mobiles & Laptops',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('EE002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'USB Cables & Chargers',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('EE003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Earphones & Speakers',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('EE004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Back Cover , Skin & Tempered glass',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isHealthAndFitness,
                title: Text("Health & Fitness Products "),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('HF001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Protein & Mass Gainers',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('HF002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Vitamins , Minerals & Pre-workout',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('HF003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Shaker , Gloves & Fat grips',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('HF004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Yoga mats , Medicine ball & Resistance bands',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isLifeStyle,
                title: Text("LifeStyle Products "),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('LS001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Perfumes & Deos',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('LS002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Body Moisturizer , Creams & Combs',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('LS003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Shampoos , Conditioner & Dryer',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('LS004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Lip Balm , Lipsticks & Nail Polish',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isMedicine,
                title: Text("Medicine Products "),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('ME001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Antibiotics Medicines',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('ME002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Cold-Cough , Fever & Headache Medicines',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('ME003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Bandage , Cotton Pads & Patti',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('ME004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Sanitary Pads , Contraceptive Pills & Condoms',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isMenClothing,
                title: Text("Men's Clothing"),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('MC001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Shirts , T-shirts & Denim Jeans',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('MC002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Formal Pants , Shirts & Shoes',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('MC003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Coat , Jackets & Pullovers',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('MC004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Shorts , Trousers & Gym Wears',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: ExpansionTile(
                initiallyExpanded: isWomenClothing,
                title: Text("Women's Clothing "),
                backgroundColor: Colors.white,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('WC001');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Ethnic & FusionWear',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('WC002');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Western Wears',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('WC003');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Sleepwear & LoungeWear',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              navigateToDetailScreen('WC004');
                            },
                            textColor: Colors.white,
                            color: Colors.lightGreen,
                            child: Text(
                              'Sports & ActiveWear',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 14.0, fontStyle: FontStyle.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  navigateToDetailScreen(String subCategoryValue) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductList(subCategory: subCategoryValue)),
    );
  }
}

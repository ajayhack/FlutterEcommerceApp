import 'package:carousel_pro/carousel_pro.dart';
import 'package:indian_ecommerce_app/screens/productCategoryScreen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Indian E-commerce Shop'),
      ),
      body: getBannerCarousels(context),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                accountName: Text("Ajay Thakur"),
                accountEmail: Text("ajay49811@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text("My Order"),
              leading: Icon(Icons.shop),
            ),
            ListTile(
              title: Text("My Favourites"),
              leading: Icon(Icons.favorite),
            ),
            ListTile(
              title: Text("Help"),
              leading: Icon(Icons.help),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: onBottomNavigationTapped,
      ),
    );
  }

  onBottomNavigationTapped(int index) {
    String msg = "";
    setState(() {
      //_selectedIndex = index;
      if (index == 0) {
      } else if (index == 1) {
        navigateScreen(ProductCategoryScreen(
          isExpanded: null,
        ));
      } else {
        msg = "Cart Clicked!!";
      }
      //_showAlertDialog("Alert", msg);
    });
  }

  //Below method is used to handle navigate screen:-
  navigateScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  void _showAlertDialog(String title, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context, rootNavigator: false).pop();
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    //ShowDialog method to Show Dialog on Screen with Ok Button in it:-
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return WillPopScope(
            // ignore: missing_return
            onWillPop: () {},
            child: alertDialog);
      },
    );
  }

  //Below method is used to inflate Banner Carousel Image Slider inside Body:-
  getBannerCarousels(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: new Stack(
                  children: <Widget>[
                    Carousel(
                      images: [
                        Image.asset(
                            'assets/images/daily_essentials_images/dailyBannerOne.jpg'),
                        Image.asset(
                            'assets/images/daily_essentials_images/dailyBannerTwo.png'),
                        Image.asset(
                            'assets/images/daily_essentials_images/dailyBannerThree.jpg'),
                        Image.asset(
                            'assets/images/daily_essentials_images/dailyBannerFour.jpg')
                      ],
                      borderRadius: false,
                      boxFit: BoxFit.contain,
                    ),
                    Center(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          carouselOnClick(context, 'DE');
                        },
                        child: Text(
                          'Daily Essential Products SHOP NOW',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 14.0, fontStyle: FontStyle.normal),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: new Stack(
                  children: <Widget>[
                    Carousel(
                      images: [
                        Image.asset(
                            'assets/images/electronics_images/electronicsBannerOne.jpg'),
                        Image.asset(
                            'assets/images/electronics_images/electronicsBannerTwo.jpg')
                      ],
                      borderRadius: false,
                      boxFit: BoxFit.contain,
                    ),
                    Center(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          carouselOnClick(context, 'EE');
                        },
                        child: Text(
                          'Electronic Products SHOP NOW',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 14.0, fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: new Stack(
                  children: <Widget>[
                    Carousel(
                      images: [
                        Image.asset(
                            'assets/images/health_fitness_images/healthBannerOne.jpg'),
                        Image.asset(
                            'assets/images/health_fitness_images/healthBannerTwo.jpg'),
                        Image.asset(
                            'assets/images/health_fitness_images/healthBannerThree.jpg'),
                        Image.asset(
                            'assets/images/health_fitness_images/healthBannerFour.jpg')
                      ],
                      borderRadius: false,
                      boxFit: BoxFit.contain,
                    ),
                    Center(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          carouselOnClick(context, 'HF');
                        },
                        child: Text(
                          'Health & Fitness Products SHOP NOW',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 14.0, fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: new Stack(
                children: <Widget>[
                  Carousel(
                    images: [
                      Image.asset(
                          'assets/images/lifestyle_images/lifestyleBannerOne.png'),
                      Image.asset(
                          'assets/images/lifestyle_images/lifestyleBannerTwo.png')
                    ],
                    borderRadius: false,
                    boxFit: BoxFit.contain,
                  ),
                  Center(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black.withOpacity(0.5),
                      onPressed: () {
                        carouselOnClick(context, 'LS');
                      },
                      child: Text(
                        'LifeStyle Products SHOP NOW',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14.0, fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 210,
            width: double.infinity,
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: new Stack(
                children: <Widget>[
                  Carousel(
                    images: [
                      Image.asset(
                          'assets/images/medicine_images/medicineBannerOne.jpg'),
                      Image.asset(
                          'assets/images/medicine_images/medicineBannerTwo.jpg')
                    ],
                    borderRadius: false,
                    boxFit: BoxFit.contain,
                  ),
                  Center(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black.withOpacity(0.5),
                      onPressed: () {
                        carouselOnClick(context, 'ME');
                      },
                      child: Text(
                        'Medicine Products SHOP NOW',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14.0, fontStyle: FontStyle.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 230,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: new Stack(
                  children: <Widget>[
                    Carousel(
                      images: [
                        Image.asset(
                            'assets/images/mens_clothing_images/menClothingBannerOne.jpg'),
                        Image.asset(
                            'assets/images/mens_clothing_images/menClothingBannerTwo.jpg'),
                        Image.asset(
                            'assets/images/mens_clothing_images/menClothingBannerThree.jpg')
                      ],
                      borderRadius: false,
                      boxFit: BoxFit.contain,
                    ),
                    Center(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.black.withOpacity(0.5),
                        onPressed: () {
                          carouselOnClick(context, 'MC');
                        },
                        child: Text(
                          'Men Clothing SHOP NOW',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 14.0, fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 220,
            width: double.infinity,
            child: Card(
              color: Colors.white,
              elevation: 2.0,
              child: new Stack(
                children: <Widget>[
                  Carousel(
                    images: [
                      Image.asset(
                          'assets/images/womens_clothing_images/womenClothingBannerOne.jpeg'),
                      Image.asset(
                          'assets/images/womens_clothing_images/womenClothingBannerTwo.jpg'),
                      Image.asset(
                          'assets/images/womens_clothing_images/womenClothingBannerThree.png')
                    ],
                    borderRadius: false,
                    boxFit: BoxFit.contain,
                  ),
                  Center(
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black.withOpacity(0.5),
                      onPressed: () {
                        carouselOnClick(context, 'WC');
                      },
                      child: Text(
                        'Women Clothing SHOP NOW',
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 14.0, fontStyle: FontStyle.normal),
                      ),
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

  carouselOnClick(BuildContext context, String categoryName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ProductCategoryScreen(isExpanded: categoryName)),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

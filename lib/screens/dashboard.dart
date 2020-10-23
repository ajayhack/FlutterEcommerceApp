import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:indian_ecommerce_app/screens/orders.dart';
import 'package:indian_ecommerce_app/screens/productCategoryScreen.dart';
import 'package:indian_ecommerce_app/screens/shoppingCart.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'favourites.dart';
import 'login.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DashboardScreenState();
  }
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  int cartCount = 0;
  String fullName = "";
  String userName = "";

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  final scrollController = ScrollController();
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartCount = await dbHelper.addedProductToCartCount();
    print('Shopping Cart Products: $cartCount');
    fullName = prefs.getString('fullName') ?? "";
    userName = prefs.getString('userName') ?? "";
    print(fullName);
    print(userName);
    setState(() {
      fullName = fullName;
      userName = userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          primary: true,
        appBar: ScrollAppBar(
          controller: scrollController,
          backgroundColor: Colors.green,
          title: Text('Indian E-commerce Shop'),
        ),
        body: getBannerCarousels(context),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: UserAccountsDrawerHeader(
                  accountName: Text(fullName),
                  accountEmail: Text(userName),
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
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
            ),
              ListTile(
                title: Text("My Order"),
                onTap: () => showOrders(),
                leading: Icon(Icons.shop),
              ),
              ListTile(
                title: Text("My Favourites"),
                onTap: () => showFavourites(),
                leading: Icon(Icons.favorite),
              ),
              ListTile(
                title: Text("Add Product"),
                onTap: () => openCamera(),
                leading: Icon(Icons.camera_alt),
              ),
              ListTile(
                title: Text("Help"),
                onTap: () => launch("tel:9560607953"),
                leading: Icon(Icons.help),
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () => logoutConfirmationDialog(),
                leading: Icon(Icons.logout),
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
        ),
    );
  }

  //Below method is used to open image picker:-
  Future openCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //Below method is to handle bottom navigation onClick:-
  onBottomNavigationTapped(int index) {
    setState(() {
      if (index == 0) {
        //OnClick of Home.....
      } else if (index == 1) {
        navigateScreen(ProductCategoryScreen(isExpanded: null), true);
      } else {
        dbHelper.queryAllShoppingCartRows().then((value) =>
            navigateScreen(ShoppingCart(cartData: value), true)
        );
      }
    });
  }

  //Below method is used to navigate user to show there favourite products:-
  showFavourites() {
    Navigator.pop(context);
    dbHelper.queryAllFavouritesRows().then((value) =>
        navigateScreen(Favourites(favData: value), true)
    );
  }

  //Below method is used to navigate user to show there orders products:-
  showOrders() {
    Navigator.pop(context);
    dbHelper.queryAllOrdersRows().then((value) =>
        navigateScreen(Orders(orderData: value), true)
    );
  }

  //Below method is used to logout user from app and also clear all shared preference and db data of it:-
  logout() async {
    Navigator.pop(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("isLogin", 0)
        .then((value) =>
        showToast("Logout Successfully", Colors.green, Colors.white))
        .then((value) =>
        Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) => Login(),),
              (route) => false,));
  }

  //Below method is sued to show Order Confirmation Dialog to user:-
  logoutConfirmationDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text('Exit'),
            content: Text('Do you want to Logout from App?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () =>
                {
                  Navigator.of(context).pop(false),
                  logout()
                },
                child: Text('Yes'),
              ),
            ],
          ),
    ) ??
        false;
  }

  //Below method is used to handle navigate screen:-
  navigateScreen(Widget screen, bool isBackStack) {
    if (isBackStack) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    }
  }

  //Below method is used to inflate Banner Carousel Image Slider inside Body:-
  getBannerCarousels(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    return SingleChildScrollView(
      controller: scrollController,
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
                          carouselOnClick('DE');
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
                          carouselOnClick('EE');
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
                          carouselOnClick('HF');
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
                        carouselOnClick('LS');
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
                        carouselOnClick('ME');
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
                          carouselOnClick('MC');
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
                        carouselOnClick('WC');
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

  carouselOnClick(String categoryName) {
    navigateScreen(ProductCategoryScreen(isExpanded: categoryName), true);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  //Below method is used to show Login Validation Toast Message in App:-
  showToast(String validMsg, Color validBackGroundColor, Color validTextColor) {
    Fluttertoast.showToast(
        msg: validMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: validBackGroundColor,
        textColor: validTextColor,
        fontSize: 16.0
    );
  }

  //Below method is used to show back press exit Dialog on Dashboard:-
  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => SystemNavigator.pop(),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }
}

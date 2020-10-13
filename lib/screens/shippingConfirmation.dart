import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:indian_ecommerce_app/screens/login.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ShippingConfirmation extends StatefulWidget {
  final List<Map<String, dynamic>> orderData;

  ShippingConfirmation({Key key, @required this.orderData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Shipping(orderData);
  }
}

class Shipping extends State<ShippingConfirmation> {
  final fullNameController = TextEditingController();
  final userMobileNumberController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  var allOrderData;

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  Shipping(List<Map<String, dynamic>> orderData) {
    allOrderData = orderData;
    print('Favourite Data:- $orderData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Shipping Address'),
          automaticallyImplyLeading: false),
      body: getDisplayShippingAddressView(context),
    );
  }

  //Below method is used to display SignUp View on the SignUp Page Layout:-
  getDisplayShippingAddressView(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: Center(
                child: Text(
                  'Order Delivery Address',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontStyle: FontStyle.normal,
                      color: Colors.green),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 0.0),
              child: Card(
                color: Colors.white,
                elevation: 5.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 50,
                        controller: fullNameController,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Full Name',
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 50,
                        controller: userMobileNumberController,
                        maxLines: 1,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Mobile Number',
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 50,
                        controller: cityController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'City',
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 50,
                        controller: stateController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'State',
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 50,
                        controller: pinCodeController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'PinCode',
                            fillColor: Colors.white,
                            filled: true,
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {
                          order();
                        },
                        child: Text(
                          'Order Now',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 16.0, fontStyle: FontStyle.normal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  order() {
    if (fullNameController.text.isEmpty) {
      userValidationToast(
          "Full Name field should not be empty", Colors.red, Colors.white);
    } else if (userMobileNumberController.text.isEmpty) {
      userValidationToast(
          "Mobile Number field should not be empty", Colors.red, Colors.white);
    } else if (cityController.text.isEmpty) {
      userValidationToast(
          "City field should not be empty", Colors.red, Colors.white);
    } else if (stateController.text.isEmpty) {
      userValidationToast(
          "State field should not be empty", Colors.red, Colors.white);
    } else if (pinCodeController.text.isEmpty) {
      userValidationToast(
          "PinCode field should not be empty", Colors.red, Colors.white);
    } else {
      confirmationDialog();
    }
  }

  void insertOrder() async {
    SystemNavigator.pop();
    final ProgressDialog progressDialog = ProgressDialog(
        context, type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false);
    await progressDialog.show();
    var dateTime = DateTime.now();
    Map<String, dynamic> row = {
      DatabaseHelper.shippingId: dateTime.year +
          dateTime.month +
          dateTime.day +
          dateTime.hour +
          dateTime.minute +
          dateTime.second,
      DatabaseHelper.shippingFullName: fullNameController.text,
      DatabaseHelper.shippingMobileNumber: userMobileNumberController.text,
      DatabaseHelper.shippingCity: cityController.text,
      DatabaseHelper.shippingState: stateController.text,
      DatabaseHelper.shippingPinCode: pinCodeController.text,
    };
    await dbHelper.insertShippingAddressData(row).then((value) =>
    {
      for(int i = 0; i < allOrderData.length; i++){
        updateAllCartOrder2PlacedOrders(i)
      }
    }
    );
  }

  //Below method is used to update all cart order to placed orders:-
  updateAllCartOrder2PlacedOrders(int index) async {
    Map<String, dynamic> cart = {
      DatabaseHelper.productId: allOrderData[index]["productId"],
      DatabaseHelper
          .productSerialNumber: allOrderData[index]["productSerialNumber"],
      DatabaseHelper.productTitle: allOrderData[index]["productTitle"],
      DatabaseHelper.productMrp: allOrderData[index]["productMrp"],
      DatabaseHelper.productDiscount: allOrderData[index]["productDiscount"],
      DatabaseHelper.productPrice: allOrderData[index]["productPrice"],
      DatabaseHelper.isFavourite: 2
    };
    await dbHelper.updateToOrder(cart).then((value) =>
    {
      if(value > 0){
        userValidationToast(
            "Order Placed Successfully", Colors.green, Colors.white),

        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()),)
      } else
        {
          await progressDialog.hide()
        }
    }
    )
  }

  //Below method is sued to show Order Confirmation Dialog to user:-
  confirmationDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          AlertDialog(
            title: Text('Confirmation?'),
            content: Text('Please click Yes to Confirm Order'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => insertOrder(),
                child: Text('Yes'),
              ),
            ],
          ),
    ) ??
        false;
  }

  //Below method is used to show SignUp Validation Toast Message in App:-
  userValidationToast(String validMsg, Color validBackGroundColor,
      Color validTextColor) {
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
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:indian_ecommerce_app/screens/login.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignIn();
  }
}

class SignIn extends State<SignUp> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('SignUp'),
          automaticallyImplyLeading: false),
      body: getDisplaySignUpView(context),
    );
  }

  //Below method is used to display SignUp View on the SignUp Page Layout:-
  getDisplaySignUpView(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: Center(
                child: Text(
                  'Indian Ecommerce Shop',
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
                        obscureText: true,
                        maxLength: 20,
                        controller: passwordController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: true,
                        maxLength: 20,
                        controller: confirmPasswordController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
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
                          insert();
                        },
                        child: Text(
                          'SignUp',
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

  doSignUp() {
    if (passwordController.text == confirmPasswordController.text)
      insert();
    else
      log('signUpError: Password Not Matches');
  }

  void insert() async {
    // row to insert
    var dateTime = DateTime.now();
    Map<String, dynamic> row = {
      DatabaseHelper.signUpId: dateTime.year +
          dateTime.month +
          dateTime.day +
          dateTime.hour +
          dateTime.minute +
          dateTime.second,
      DatabaseHelper.fullName: fullNameController.text,
      DatabaseHelper.password: passwordController.text,
      DatabaseHelper.dateTime: dateTime.toString()
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
}

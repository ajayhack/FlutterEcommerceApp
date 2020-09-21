import 'package:flutter/material.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:indian_ecommerce_app/screens/dashboard.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogIn();
  }
}

class LogIn extends State<Login> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Login'),
          automaticallyImplyLeading: false),
      body: getDisplayLoginView(),
    );
  }

  //Below method is used to display SignUp View on the SignUp Page Layout:-
  getDisplayLoginView() {
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
                        controller: userNameController,
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            fillColor: Colors.white,
                            filled: true,
                            labelText: 'User Name',
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
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {
                          doLogin();
                        },
                        child: Text(
                          'Login',
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

  doLogin() async {
    var login = await dbHelper.checkLogin(
        userNameController.text, passwordController.text);
    print('Login Success: $login');
    addBoolToSF();
    if (login > 0)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    else
      print('Login Failed: $login');
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', true);
  }
}

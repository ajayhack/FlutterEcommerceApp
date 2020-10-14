import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indian_ecommerce_app/database/database_helper.dart';
import 'package:indian_ecommerce_app/screens/dashboard.dart';
import 'package:indian_ecommerce_app/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogIn();
  }
}

class LogIn extends State<Login> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  String fullName="";
  String userName="";

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
                      child: Container(
                        width: double.infinity,
                        height: 50,
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
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () => navigateUser(
                            SignUp(),
                          ),
                          child: Text(
                            'SignUp',
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 16.0, fontStyle: FontStyle.normal),
                          ),
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
    if(userNameController.text.isEmpty){
      userValidationToast("UserName field should not be empty", Colors.red, Colors.white);
    }else if(passwordController.text.isEmpty){
      userValidationToast("Password field should not be empty", Colors.red, Colors.white);
    }else {
      var login = await dbHelper.checkLogin(
          userNameController.text, passwordController.text);
      print('Login Success: $login');
      addPreferenceValue();
      if (login > 0) {
        userValidationToast(
            "User Login successfully", Colors.green, Colors.white);
        navigateUser(DashboardScreen(),);
      }
      else {
        userValidationToast(
            "User Login Failed , Please check your UserName & Password",
            Colors.red, Colors.white);
        print('Login Failed: $login');
      }
    }
  }

  //Below method is used to navigate user to Dashboard or SignUp Screen:-
  navigateUser(Widget screen) {
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => screen),);
  }

  //Below method is used to save Login Status value in SharedPreference:-
  addPreferenceValue() async {
    var userData = await dbHelper.queryAllSignUpRows();
    fullName = userData[0]["fullName"];
    userName = userData[0]["userName"];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("isLogin", 1);
    prefs.setString('fullName', fullName);
    prefs.setString('userName', userName);
    print(prefs.getString('fullName'));
    print(prefs.getString('userName'));
  }

  //Below method is used to show Login Validation Toast Message in App:-
  userValidationToast(String validMsg , Color validBackGroundColor , Color validTextColor){
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

import 'package:flutter/material.dart';
import 'package:indian_ecommerce_app/screens/dashboard.dart';
import 'package:indian_ecommerce_app/screens/login.dart';
import 'package:indian_ecommerce_app/screens/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var loginStatus = prefs.getInt('isLogin') ?? 2;
  print(loginStatus);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginStatus == 0
          ? Login()
          : loginStatus == 1
              ? DashboardScreen()
              : SignUp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indian Ecommerce Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SignUp(),
    );
  }

  checkAndShowScreen(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasKey = prefs.containsKey("isLogin");
    if (hasKey) {
      bool boolValue = prefs.getBool('isLogin');
      if (boolValue) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUp()),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUp()),
      );
    }
  }
}

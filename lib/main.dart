import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbank/route_generators.dart';
import 'package:smartbank/screens/homeScreen.dart';
import 'package:smartbank/screens/loginScreen.dart';
import 'package:smartbank/screens/splashScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //  return MaterialApp(title: "Get started", home: GetStarted());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartBank',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: CheckAuth(),

    );
  }
}



class CheckAuth extends StatefulWidget {
  @override
  _CheckAuthState createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      if (mounted) {
        setState(() {
          isAuth = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isAuth) {
      child = HomeScreen();
    } else {
      child = SplashScreen();
    }

    return Scaffold(
      body: child,
    );
  }
}

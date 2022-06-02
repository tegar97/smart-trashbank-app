
import 'package:flutter/material.dart';
import 'package:smartbank/screens/homeScreen.dart';
import 'package:smartbank/screens/loginScreen.dart';
import 'package:smartbank/screens/registerScreen.dart';
import 'package:smartbank/screens/splashScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
  
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('Erorr'),
        ),
      );
    });
  }
}

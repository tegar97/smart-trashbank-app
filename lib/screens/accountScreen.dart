import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbank/screens/loginScreen.dart';
import 'package:smartbank/shared/themes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: Center(
              child: GestureDetector(
            onTap: () {
              logout();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              color: Primary,
              child: Text("Logout", style: textWhiteStyle),
            ),
          )),
        ));
  }

  void logout() async {
    // var res = await Network().getData('/logout');
    // var body = json.decode(res.body);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('user');
    localStorage.remove('token');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // if (body['success']) {
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.remove('user');
    //   localStorage.remove('token');
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LoginScreen()));
    // }else{
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text("Error"))
    //       );

    // }
  }
}

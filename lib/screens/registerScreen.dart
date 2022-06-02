import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbank/Widget/input.dart';
import 'package:smartbank/network/api.dart';
import 'package:smartbank/screens/homeScreen.dart';
import 'package:smartbank/shared/themes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool value = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  TextEditingController? code = TextEditingController();
  TextEditingController? name = TextEditingController();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    // Scaffold.of(context).showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            title: Text(
              'Register',
              style: textBlackStyle.copyWith(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: TextBlack,
                size: 18,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )),
        backgroundColor: backgroundColor,
        body: ListView(
          padding: EdgeInsets.only(left: 17, right: 17, bottom: 10, top: 47),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi,Welcome 👋',
                  style: textBlackStyle.copyWith(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Let’s create your account',
                  style: textAccentStyle.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 37,
            ),
            Column(
              children: [
                InputField(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  stateName: name!,
                ),
                SizedBox(
                  height: 21,
                ),
                InputField(
                  labelText: 'Email Address',
                  hintText: 'Enter your email Address',
                  type: 'email',
                  stateName: email!,
                ),
                SizedBox(
                  height: 21,
                ),
                InputField(
                  labelText: 'Code',
                  hintText: 'Enter your code',
                  stateName: code!,
                ),
                SizedBox(
                  height: 21,
                ),
                InputField(
                  labelText: 'Password',
                  hintText: 'Enter your passwoord',
                  type: 'password',
                  stateName: password!,
                ),
                SizedBox(
                  height: 14,
                ),
              ],
            ),
            SizedBox(
              height: 57,
            ),
            Column(
              children: [
                Container(
                  width: widthDevice,
                  height: 56,
                  child: TextButton(
                    onPressed: () {
                      _register();
                    },
                    child: Text(
                      "Register",
                      style: textWhiteStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account ? ',
                        style: textAccentStyle.copyWith(fontSize: 13)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('login',
                          style: textPrimaryStyle.copyWith(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'email': email?.text,
      'password': password?.text,
      'name': name?.text,
      'code': code?.text
    };

    var res = await Network().auth(data, '/register');
    var body = json.decode(res.body);
    if (body['success'] ?? true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(body['token']));
      localStorage.setString('user', json.encode(body['user']));
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbank/Widget/input.dart';
import 'package:smartbank/network/api.dart';
import 'package:smartbank/screens/homeScreen.dart';
import 'package:smartbank/shared/themes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool value = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? email = TextEditingController();
  TextEditingController? password = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

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
            'Login',
            style: textBlackStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: Icon(
            Icons.arrow_back_ios,
            color: TextBlack,
            size: 18,
          ),
        ),
        backgroundColor: backgroundColor,
        body: ListView(
          padding: EdgeInsets.only(left: 17, right: 17, bottom: 10, top: 47),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi,Welcome Back! 👋',
                  style: textBlackStyle.copyWith(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Happy to see you again,please login here',
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
                  labelText: 'Email Address',
                  hintText: 'Enter your email Address',
                  type: 'email',
                  stateName: email!,
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
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              checkColor: Color(0xFF5B5B5B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              side: MaterialStateBorderSide.resolveWith(
                                (states) =>
                                    BorderSide(width: 1.0, color: borderColor),
                              ),
                              value: this.value,
                              activeColor: backgroundColor,
                              onChanged: (newValue) {
                                setState(() {
                                  value = newValue!;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text('Remember me ',
                              style: textBlackStyle.copyWith(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Text(
                      'Forgot password',
                      style: textWarningStyle,
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 57,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _login();
                  },
                  child: Container(
                    width: widthDevice,
                    height: 56,
                    color: Primary,
                    child: Center(
                      child: Text(
                        "Login",
                        style: textWhiteStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 17,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don’t have an account ? ',
                        style: textAccentStyle.copyWith(fontSize: 13)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text('Register',
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

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'email': email?.text, 'password': password?.text};
    var res = await Network().auth(data, '/login');
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

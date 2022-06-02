import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartbank/shared/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    Timer(Duration(seconds: 3),
        () => Navigator.pushNamed(context, '/login'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: backgroundColor, // Navigation bar
            statusBarColor: backgroundColor, // Status bar
          ),
        ),
        body: SafeArea(
          child: Container(
            width: widthDevice,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Smart',
                            style: textPrimaryStyle.copyWith(
                                fontSize: 40, fontWeight: FontWeight.w700)),
                        Text(
                          'Bank',
                          style: textBlackStyle.copyWith(
                              fontSize: 40, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(height: 7,),
                    Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
        
                      children: [Text(
                        'Le’ts change the world with us',
                        style: textAccentStyle.copyWith(
                          fontSize: 17
                        )
                      )],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

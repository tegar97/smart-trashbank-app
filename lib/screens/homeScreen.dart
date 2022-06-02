import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartbank/network/api.dart';
import 'package:smartbank/screens/accountScreen.dart';
import 'package:smartbank/screens/loginScreen.dart';
import 'package:smartbank/shared/themes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String balance = '';
  String totalBottle = '';
  int _selectedIndex = 0;
  String rfid = "0";
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user')!);

    if (user != null) {
      setState(() {
        name = user['name'];
        balance = user['balance'].toString();
        totalBottle = user['totalBottle'].toString();
        rfid = user['rfid'];
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
        double widthDevice = MediaQuery.of(context).size.width;

    Widget widget = Container();
    switch (_selectedIndex) {
      case 0:
        widget = ListView(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      padding: EdgeInsets.all(17),
                      width: widthDevice,
                      height: 200,
                      color: Primary,
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/avatar_2.png'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Good Morning,${'${name}'}! ',
                                      style: textWhiteStyle.copyWith(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                          SizedBox(height: 5,),
                                  Text(
                                      'rfid : ${rfid}',
                                      style: textAccentSecondaryStyle.copyWith(
                                        fontSize: 13,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 31,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Balance',
                                      style: textWhiteStyle,
                                    ),
                                    SizedBox(
                                      height: 11,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text('Rp', style: textWhiteStyle),
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Text('${balance}',
                                            style: textWhiteStyle.copyWith(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Bottle Collected',
                                    style: textWhiteStyle,
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 1,
                                      ),
                                      Text('${totalBottle} pcs',
                                          style: textWhiteStyle.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Positioned(
                    //   child: Container(
                    //     padding: EdgeInsets.all(15),
                    //     width: widthDevice * 0.8,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         logout();
                    //       },
                    //       child: Text("Logout"),
                    //     ),
                    //     color: Colors.red,
                    //   ),
                    //   bottom: 0,
                    //   left: 20,
                    //   right: 20,
                    // )
                  ]),
                  Container(
                    padding: EdgeInsets.all(defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Withdraw",
                            style: textBlackStyle.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(height: 20),
                        Container(
                          width: widthDevice,
                          height: 60,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                  width: 80,
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/dana.png'),
                                      SizedBox(height: 10   ),
                                      Text("Dana",style : textAccentThirdStyle.copyWith(
                                        fontSize: 13
                                      ))
                                    ],
                                  )),
                              Container(
                                  width: 80,
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/gopay.png'),
                                     SizedBox(height: 10),
                                      Text("Gopay",
                                          style: textAccentThirdStyle.copyWith(
                                              fontSize: 13))
                                    ],
                                  )),
                              Container(
                                  width: 80,
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/ovo.png'),
                                       SizedBox(height: 10),
                                      Text("Ovo",
                                          style: textAccentThirdStyle.copyWith(
                                              fontSize: 13))
                                    ],
                                  )),
                              Container(
                                  width: 80,
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/btc.png'),
                                       SizedBox(height: 10),
                                      Text("Bitcoin",
                                          style: textAccentThirdStyle.copyWith(
                                              fontSize: 13))
                                    ],
                                  )),
                              Container(
                                  width: 80,
                                  height: 80,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/linkaja.png'),
                                     SizedBox(height: 10),
                                      Text("Linkaja",
                                          style: textAccentThirdStyle.copyWith(
                                              fontSize: 13))
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Promo ",
                            style: textBlackStyle.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w500)),
                        SizedBox(height: 20),
                        Container(
                          width: widthDevice,
                          height: 300,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                  width: 400,
                                  height: 113,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/banner3.jpg'),
                                    ],
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                  width: 400,
                                  height: 113,
                                  child: Column(
                                    children: [
                                      Image.asset('assets/banner3.jpg'),
                                    ],
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
        break;

      case 2:
        widget = AccountScreen();
        break;
    }


    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Ranking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'akun',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Primary,
        onTap: _onItemTapped,
      ),
      body: widget,
    );
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

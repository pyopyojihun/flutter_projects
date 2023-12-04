import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

const HOME_ROUTE = '/'; //이런식으로 관리하는 방법이 나은듯.
void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    //home: HomeScreen(),
    routes: {
      HOME_ROUTE: (context) => HomeScreen(),
      '/one': (context) => RouteOneScreen(),
      '/two': (context) => RouteTwoScreen(),
      '/three': (context) => RouteThree(),
    },
  ));
}

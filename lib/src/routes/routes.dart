import 'package:flutter/material.dart';
import 'package:paws/src/pages/default.dart';
import 'package:paws/src/pages/home.dart';
import 'package:paws/src/pages/login.dart';
import 'package:paws/src/pages/register_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomePage(),
    'login': (BuildContext context) => LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
    'defaul': (BuildContext context) => DefaultPage(),
  };
}

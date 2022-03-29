import 'package:flutter/material.dart';
import 'package:my_circle/index_screen.dart';
import 'package:my_circle/ui/auth/login_screen.dart';
import 'package:my_circle/ui/auth/register_screen.dart';
import 'package:my_circle/ui/home/home_screen.dart';
import 'package:my_circle/ui/my_bottom_navbar.dart';

MaterialPageRoute _pageRoute({
  required RouteSettings settings,
  required Widget body,
}) =>
    MaterialPageRoute(
      builder: (_) => body,
      settings: settings,
    );

Route? generateRoute(RouteSettings settings) {
  Route? _route;
  final _args = settings.arguments;
  switch (settings.name) {
    case rLogin:
      _route = _pageRoute(settings: settings, body: LoginScreen());
      break;
    case rRegister:
      _route = _pageRoute(settings: settings, body: RegisterScreen());
      break;
    case rIndex:
      _route = _pageRoute(settings: settings, body: IndexScreen());
      break;
    case rHome:
      _route = _pageRoute(settings: settings, body: MyBottomNavbar());
      break;
  }
  return _route;
}

// global route variable
const String rIndex = '/';
const String rRegister = '/register';
const String rLogin = '/login';
const String rHome = '/home';

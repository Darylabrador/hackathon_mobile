import 'package:flutter/material.dart';

class RouteService {
  static RouteService _instance = RouteService._internal();

  RouteService._internal();

  static RouteService getInstance() {
    if (_instance == null) {
      _instance = RouteService._internal();
    }
    return _instance;
  }

  welcomeRoute(String routeName, BuildContext context) {
    if (ModalRoute.of(context)!.settings.name.toString() == "/" ||
        ModalRoute.of(context)!.settings.name.toString() == routeName) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(
      routeName,
    );
  }

  generalRoute(String routeName, BuildContext context) {
    if (ModalRoute.of(context)!.settings.name.toString() == routeName) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(
      routeName,
    );
  }
}

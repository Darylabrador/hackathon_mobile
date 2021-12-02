import 'package:flutter/cupertino.dart';

class RouteService {
  static welcomeRoute(String routeName, BuildContext context) {
    if (ModalRoute.of(context)!.settings.name.toString() == "/" ||
        ModalRoute.of(context)!.settings.name.toString() == routeName) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(
      routeName,
    );
  }

  static generalRoute(String routeName, BuildContext context) {
    if (ModalRoute.of(context)!.settings.name.toString() == routeName) {
      return;
    }
    Navigator.of(context).pushReplacementNamed(
      routeName,
    );
  }
}

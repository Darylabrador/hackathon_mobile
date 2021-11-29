import 'package:flutter/material.dart';

import './screens/dashboard_screen.dart';
import './screens/forgotten_pwd_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      DashboardScreen.routeName: (ctx) => const DashboardScreen(),
      ForgottenPwdScreen.routeName: (ctx) => const ForgottenPwdScreen(),
    };
  }
}

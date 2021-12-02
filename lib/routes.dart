import 'package:flutter/material.dart';

import './screens/dashboard_screen.dart';
import './screens/forgotten_pwd_screen.dart';
import './screens/project_screen.dart';
import './screens/recapitulatif_screen.dart';
import './screens/team_management_screen.dart';
import './screens/account_settings_screen.dart';
import './screens/account_delete_confirm_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> appRoutes() {
    return {
      DashboardScreen.routeName: (ctx) => const DashboardScreen(),
      ForgottenPwdScreen.routeName: (ctx) => const ForgottenPwdScreen(),
      ProjectScreen.routeName: (ctx) => const ProjectScreen(),
      RecapitulatifScreen.routeName: (ctx) => const RecapitulatifScreen(),
      TeamManagementScreen.routeName: (ctx) => const TeamManagementScreen(),
      AccountSettingsScreen.routeName: (ctx) => const AccountSettingsScreen(),
      AccountDeleteConfirmScreen.routeName: (ctx) => const AccountDeleteConfirmScreen(),
    };
  }
}

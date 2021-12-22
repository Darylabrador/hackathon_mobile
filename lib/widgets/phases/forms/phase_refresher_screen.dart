import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../screens/dashboard_screen.dart';
import '../../../utils/snackbar.dart';

class PhaseRefresherScreen {
  static void refreshScreen(
    BuildContext context,
    String message,
    bool success,
  ) {
    Snackbar.showScaffold(
      message,
      success,
      context,
    );
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: const DashboardScreen(),
      ),
    );
  }
}

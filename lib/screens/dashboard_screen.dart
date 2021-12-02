import 'package:flutter/material.dart';
import '../layout/custom_background_scroll.dart';

import '../widgets/navigation/app_drawer.dart';
import '../widgets/components/card_header.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon dashboard"),
      ),
      drawer: const AppDrawer(),
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: [
              CardHeader.content(
                context: context,
                mediaQuery: mediaQuery,
                topSpace: SizedBox(height: mediaQuery.size.height * 0.08),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

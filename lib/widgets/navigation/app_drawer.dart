import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../utils/palette.dart';

import '../../providers/auth_provider.dart';

import '../../screens/login_screen.dart';
import '../../screens/dashboard_screen.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext? customContext;
  const AppDrawer({
    Key? key,
    this.customContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(customContext ?? context).copyWith(
        hoverColor: Colors.grey[800],
        canvasColor: Palette.bluePostale,
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 130,
              child: DrawerHeader(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        hoverColor: Colors.transparent,
                        color: Colors.white,
                        icon: const Icon(MdiIcons.arrowLeft),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/default.png"),
                              ),
                              const SizedBox(height: 10,),
                              FittedBox(
                                child: Text(
                                  Provider.of<AuthProvider>(
                                          customContext ?? context)
                                      .identity as String,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        hoverColor: Colors.transparent,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(customContext ?? context)
                              .pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const LoginScreen(),
                            ),
                          );
                          Navigator.of(customContext ?? context)
                              .pushReplacementNamed(
                            LoginScreen.routeName,
                          );
                          Provider.of<AuthProvider>(customContext ?? context,
                                  listen: false)
                              .logout();
                        },
                        icon: const Icon(MdiIcons.exitToApp),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../utils/palette.dart';

import '../../providers/auth_provider.dart';
import '../../services/route_service.dart';

import '../../screens/login_screen.dart';
import '../../screens/dashboard_screen.dart';
import '../../screens/project_screen.dart';
import '../../screens/recapitulatif_screen.dart';
import '../../screens/team_management_screen.dart';
import '../../screens/account_settings_screen.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext? customContext;
  const AppDrawer({
    Key? key,
    this.customContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouteService router = RouteService.getInstance();

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
                      child: InkWell(
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
                                const SizedBox(
                                  height: 10,
                                ),
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
                        onDoubleTap: () {
                          router.generalRoute(
                            AccountSettingsScreen.routeName,
                            customContext ?? context,
                          );
                        },
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
            ListTile(
              leading: const Icon(
                MdiIcons.viewDashboard,
                color: Colors.white,
              ),
              title: Text(
                'Mon dashboard',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
              onTap: () {
                router.welcomeRoute(
                  DashboardScreen.routeName,
                  customContext ?? context,
                );
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.lightbulbOn,
                color: Colors.white,
              ),
              title: Text(
                'Mon projet',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
              onTap: () {
                router.generalRoute(
                  ProjectScreen.routeName,
                  customContext ?? context,
                );
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.fileOutline,
                color: Colors.white,
              ),
              title: Text(
                'Mon récapitulatif',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
              onTap: () {
                router.generalRoute(
                  RecapitulatifScreen.routeName,
                  customContext ?? context,
                );
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.accountGroup,
                color: Colors.white,
              ),
              title: Text(
                'Mon équipe',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
              onTap: () {
                router.generalRoute(
                  TeamManagementScreen.routeName,
                  customContext ?? context,
                );
              },
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.accountCog,
                color: Colors.white,
              ),
              title: Text(
                'Mon compte',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
              onTap: () {
                router.generalRoute(
                  AccountSettingsScreen.routeName,
                  customContext ?? context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

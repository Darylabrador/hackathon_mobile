import 'package:flutter/material.dart';
import '../screens/account_delete_confirm_screen.dart';

import '../layout/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';

import '../widgets/account/content/account_information.dart';
import '../widgets/account/content/account_password.dart';
import '../layout/custom_theme.dart';

class AccountSettingsScreen extends StatelessWidget {
  static const routeName = '/account';
  const AccountSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: CustomTheme.appTheme(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Mon compte"),
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.info),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Vos informations"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.vpn_key),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Mot de passe"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          drawer: AppDrawer(customContext: context),
          body: const CustomBackground(
            ch: TabBarView(
              children: [
                AccountInformation(),
                AccountPassword(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFFFDB00),
            onPressed: () async {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: const Text(
                    "Voulez-vous vraiment supprimer votre compte ?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        "Non",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          AccountDeleteConfirmScreen.routeName,
                        );
                      },
                      child: const Text(
                        "Oui",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}

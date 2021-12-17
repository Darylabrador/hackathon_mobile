import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/role.dart' show Role;
import '../../models/team_mates.dart' show TeamMates;
import '../../providers/team_provider.dart';

import '../components/role_select_input.dart';
import '../../utils/snackbar.dart';
import '../../screens/team_management_screen.dart';

class TeamCoreActions {
  static Widget buildButtonOrLoader({
    required BuildContext context,
    required Future<Map<String, dynamic>> actionFunction,
    required Function loadingFunction,
    required bool loading,
    required bool isRole,
    Function? handleSelect,
  }) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: const Text("Valider"),
          onPressed: () async {
            loadingFunction();
            try {
              var response = await actionFunction;

              Snackbar.showScaffold(
                response["message"],
                response["success"],
                context,
              );
            } catch (e) {
              Snackbar.showScaffold(
                e.toString(),
                false,
                context,
              );
            }

            if (isRole) {
              handleSelect!(
                const Role(name: '0 - choisir un role'),
              );
            }

            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(
              TeamManagementScreen.routeName,
            );
            loadingFunction();
          },
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          child: const Text("Annuler"),
          onPressed: () {
            if (isRole) {
              handleSelect!(
                const Role(name: '0 - choisir un role'),
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static Widget buildApproved({
    required BuildContext context,
    required TeamMates mate,
  }) {
    return IconButton(
      padding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      color: Colors.green,
      icon: const Icon(MdiIcons.checkCircle),
      onPressed: () {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext ctx) {
            var _loading = false;

            return StatefulBuilder(builder: (BuildContext context, setState) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Approuver un membre',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Divider(),
                    const SizedBox(height: 30),
                    const Text(
                      "Acceptez-vous que ce membre rejoigne votre équipe ?",
                    ),
                    const SizedBox(height: 30),
                    buildButtonOrLoader(
                      context: context,
                      loading: _loading,
                      isRole: false,
                      actionFunction: Provider.of<TeamProvider>(
                        context,
                        listen: false,
                      ).putApprouved(mate.id),
                      loadingFunction: () => setState(
                        () => {_loading = !_loading},
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }

  static Widget buildUpdateRole({
    required BuildContext context,
    required TeamMates mate,
    required Function handleSelect,
    required Role selectedRole,
  }) {
    return IconButton(
      padding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      color: Colors.blueGrey[800],
      icon: const Icon(MdiIcons.pencil),
      onPressed: () {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext ctx) {
            return SizedBox(
              height: 300,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Rôle de l'équipier",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const Divider(),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        const Text(
                          "Son rôle actuel est le suivant : ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${mate.user.role}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RoleSelectInput(
                      isValid: true,
                      handleSelect: handleSelect,
                      selectedRole: selectedRole,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: const Text("Valider"),
                        onPressed: () async {
                          try {
                            var response = await Provider.of<TeamProvider>(
                              context,
                              listen: false,
                            ).putUpdateRole(mate.id);

                            Snackbar.showScaffold(
                              response["message"],
                              response["success"],
                              context,
                            );
                          } catch (e) {
                            Snackbar.showScaffold(
                              e.toString(),
                              false,
                              context,
                            );
                          }

                          handleSelect(
                            const Role(name: '0 - choisir un role'),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacementNamed(
                            TeamManagementScreen.routeName,
                          );
                        },
                      ),
                      const SizedBox(width: 30),
                      ElevatedButton(
                        child: const Text("Annuler"),
                        onPressed: () {
                          handleSelect(const Role(name: '0 - choisir un role'));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  static Widget buildDelete({
    required BuildContext context,
    required TeamMates mate,
  }) {
    return IconButton(
      padding: EdgeInsets.zero,
      hoverColor: Colors.transparent,
      color: Colors.redAccent,
      icon: const Icon(MdiIcons.trashCan),
      onPressed: () {
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (BuildContext ctx) {
            var _loading = false;
            return StatefulBuilder(builder: (BuildContext context, setState) {
              return SizedBox(
                height: 200,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Supprimer un équipier',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const Divider(),
                    const SizedBox(height: 30),
                    const Text(
                      "Voulez-vous vraiment supprimer cet équipier ?",
                    ),
                    const SizedBox(height: 30),
                    buildButtonOrLoader(
                      context: context,
                      loading: _loading,
                      isRole: false,
                      actionFunction: Provider.of<TeamProvider>(
                        context,
                        listen: false,
                      ).deleteUserInTeam(mate.id),
                      loadingFunction: () => setState(
                        () => {_loading = !_loading},
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
    );
  }
}

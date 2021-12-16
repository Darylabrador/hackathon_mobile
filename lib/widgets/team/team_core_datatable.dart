import 'package:flutter/material.dart';

import './team_core_actions.dart';
import '../../models/team_mates.dart';
import '../../models/role.dart';

class TeamCoreDataTable {
  static List<DataColumn> dataColum = const [
    DataColumn(
      label: Text(
        "Noms",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        "Prénoms",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        "E-mails",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        "Rôles",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    DataColumn(
      label: Text(
        "Actions",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ];

  static List<DataRow> rowData(
      {required Iterable<TeamMates> iterableRows,
      required BuildContext context,
      required Function handleSelect,
      required Role selectedRole,
      required String? currentUserRole}) {
    List<DataRow> data = <DataRow>[];
    if (iterableRows.isEmpty) return data;
    for (var element in iterableRows) {
      data.add(
        DataRow(
          cells: <DataCell>[
            DataCell(FittedBox(child: Text(element.user.surname!))),
            DataCell(FittedBox(child: Text(element.user.firstname!))),
            DataCell(FittedBox(child: Text(element.user.email!))),
            DataCell(FittedBox(child: Text(element.user.role!))),
            DataCell(
              Row(
                children: [
                  if (element.approuved == 0)
                    TeamCoreActions.buildApproved(
                      context: context,
                      mate: element,
                    ),
                  if (element.approuved == 1 &&
                      element.user.role != "coach" &&
                      (currentUserRole == "chef equipe" ||
                          currentUserRole == "porteur de projet"))
                    TeamCoreActions.buildUpdateRole(
                      context: context,
                      mate: element,
                      handleSelect: handleSelect,
                      selectedRole: selectedRole,
                    ),
                  TeamCoreActions.buildDelete(
                    context: context,
                    mate: element,
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return data;
  }
}

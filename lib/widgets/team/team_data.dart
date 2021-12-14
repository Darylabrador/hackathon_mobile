import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../models/team_mates.dart' show TeamMates;

class TeamData {
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


  static List<DataRow> rowData(Iterable<TeamMates> iterableRows) {
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
                    IconButton(
                      padding: EdgeInsets.zero,
                      hoverColor: Colors.transparent,
                      color: Colors.green,
                      icon: const Icon(MdiIcons.checkCircle),
                      onPressed: () {},
                    ),
                  if (element.approuved == 1 &&
                      (element.user.role != "chef equipe" ||
                          element.user.role != "coach"))
                    IconButton(
                      padding: EdgeInsets.zero,
                      hoverColor: Colors.transparent,
                      color: Colors.blueGrey[800],
                      icon: const Icon(MdiIcons.pencil),
                      onPressed: () {},
                    ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    hoverColor: Colors.transparent,
                    color: Colors.redAccent,
                    icon: const Icon(MdiIcons.trashCan),
                    onPressed: () {},
                  ),
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
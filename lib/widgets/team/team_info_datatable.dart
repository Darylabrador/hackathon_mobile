import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_indicator/scroll_indicator.dart'; 

import '../../providers/team_provider.dart';
import '../../models/team_mates.dart' show TeamMates;

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../components/datatable/search_bart.dart';

class TeamInfoDataTable extends StatefulWidget {
  const TeamInfoDataTable({Key? key}) : super(key: key);

  @override
  _TeamInfoDataTableState createState() => _TeamInfoDataTableState();
}

class _TeamInfoDataTableState extends State<TeamInfoDataTable> {
  var _isInit = true;
  Iterable<TeamMates> iterableRows = [];
  Iterable<TeamMates> savedIterableRows = [];
  final _searchController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final initialData = await Provider.of<TeamProvider>(
        context,
        listen: false,
      ).getTeamMates();

      iterableRows = initialData;
      savedIterableRows = initialData;
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  final List<DataColumn> dataColum = const [
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

  List<DataRow> get rowData {
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
                  IconButton(
                    padding: EdgeInsets.zero,
                    hoverColor: Colors.transparent,
                    color: Colors.blueGrey,
                    icon: const Icon(MdiIcons.eye),
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

  void _resetSearch() {
    setState(() {
      iterableRows = savedIterableRows;
    });
  }

  Widget buildScrollIndicator(MediaQueryData mediaQuery) {
    return Column(
      children: [
        const SizedBox(height: 30),
        ScrollIndicator(
          scrollController: scrollController,
          width: mediaQuery.size.width * 0.3,
          height: 5,
          indicatorWidth: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          indicatorDecoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void _searchAction(String searchText) {
    if (searchText.isNotEmpty) {
      final result = savedIterableRows.where(
        (element) =>
            element.user.surname!
                .toString()
                .toLowerCase()
                .contains(searchText) ||
            element.user.firstname!
                .toString()
                .toLowerCase()
                .contains(searchText) ||
            element.user.email!.toString().toLowerCase().contains(searchText) ||
            element.user.surname!.toString().contains(searchText) ||
            element.user.firstname!.toString().contains(searchText) ||
            element.user.email!.toString().contains(searchText),
      );
      setState(() {
        iterableRows = result;
      });
    } else {
      _resetSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    if (_isInit) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchBar(
            controller: _searchController,
            searchAction: _searchAction,
            resetSearch: _resetSearch,
          ),
          if (mediaQuery.orientation == Orientation.portrait)
            buildScrollIndicator(mediaQuery),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: const BorderSide(
                color: Colors.black26,
                width: 1.0,
              ),
            ),
            elevation: 5,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    dividerThickness: 2.0,
                    columnSpacing: mediaQuery.size.width * 0.1,
                    columns: dataColum,
                    rows: rowData,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

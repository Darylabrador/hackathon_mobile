import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'team_core_datatable.dart';
import '../../providers/team_provider.dart';
import '../../models/team_mates.dart' show TeamMates;
import '../../models/role.dart';

import '../components/datatable/search_bart.dart';
import '../components/custom_scroll_indicator.dart';
import '../../screens/team_management_screen.dart';

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
  Role _selectedRole = const Role(name: '0 - choisir un role');

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      iterableRows = [];
      savedIterableRows = [];

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

  void _resetSearch() {
    setState(() {
      iterableRows = savedIterableRows;
    });
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

  void _handleSelect(Role selectedValued) {
    Provider.of<TeamProvider>(
      context,
      listen: false,
    ).setSelectedRole(selectedValued);

    setState(() {
      _selectedRole = selectedValued;
    });
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
          CustomScrollIndicator(scrollController: scrollController),
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
                    columns: TeamCoreDataTable.dataColum,
                    rows: TeamCoreDataTable.rowData(
                      iterableRows: iterableRows,
                      context: context,
                      handleSelect: _handleSelect,
                      selectedRole: _selectedRole,
                    ),
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

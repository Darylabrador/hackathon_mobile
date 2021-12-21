import 'dart:async';
import 'dart:convert';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../models/phase.dart';

class PhaseProvider with ChangeNotifier {
  final String? authToken;
  PhaseProvider({this.authToken});
  List<Phase>? _phases;
  Map<String, dynamic>? _dashboardData;
  int _currentTeamPhase = 1;

  List<Phase>? get phaseList {
    if (_phases!.isEmpty) {
      return [];
    }
    return _phases;
  }

  Map<String, dynamic>? get dashboardData {
    if (_dashboardData == null) {
      return null;
    }
    return _dashboardData;
  }

  int get currentTeamPhase {
    return _currentTeamPhase;
  }

  Future<void> getInitData() async {
    try {
      await getPhasesList();
      await getDashboardData();
    } catch (e) {
      throw HttpException("Veuillez ressayer ultérieurement");
    }
  }

  Future<void> getPhasesList() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/phases");
    List<Phase>? phasesList = <Phase>[];

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json",
        },
      );
      final responseData = jsonDecode(response.body);
      final dataArray = responseData["data"] as List<dynamic>;

      for (var element in dataArray) {
        phasesList.add(
          Phase(
            id: element['id'],
            current: element['current'],
            name: element['name'],
            fileName: element['filename'],
          ),
        );
      }

      _phases = phasesList;
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez ressayer ultérieurement");
    }
  }

  Future<void> getDashboardData() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/project");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json",
        },
      );
      final responseData = jsonDecode(response.body)['data'];
      _dashboardData = responseData;
      _currentTeamPhase = responseData!['team']['phase_actuel'];
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez ressayer ultérieurement");
    }
  }
}

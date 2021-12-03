import 'dart:async';
import 'dart:convert';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';

class RecapProvider with ChangeNotifier {
  final String? authToken;
  RecapProvider({this.authToken});

  List<dynamic>? _recapData = [];

  List<dynamic>? get recapData {
    if (_recapData!.isEmpty) {
      return [];
    }
    return _recapData;
  }

  void _setRecapData(List<dynamic>? data) {
    if (data == null || data.isEmpty) {
      return;
    }
    final displayData = [];
    for (var element in data) {
      var restructuredData = <String, dynamic>{};
      var data = element as Map<String, dynamic>;
      var phaseData = [];

      data.forEach((key, value) {
        if (key == "phase") {
          restructuredData['phase'] = value;
        }

        if (key != "phase" && key != "phaseId") {
          phaseData.add({key: value});
        }
      });

      restructuredData["data"] = phaseData;
      displayData.add(restructuredData);
    }
    _recapData = displayData;
  }

  Future<void> getProjectRecapData() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/project");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body)['data'];
      _setRecapData(responseData['project']['project_data']);
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez réessayer plus tard!");
    }
  }
}

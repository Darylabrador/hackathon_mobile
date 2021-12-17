import 'dart:async';
import 'dart:convert';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../models/help_frequency.dart';

class HelpProvider with ChangeNotifier {
  String? authToken;
  HelpProvider({this.authToken});

  HelpFrequency? _helpDetails;

  HelpFrequency? get helpDetails {
    return _helpDetails;
  }

  Future<void> getHelpFrequency() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/team/frequency");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body)['data'];
      _helpDetails = HelpFrequency(
        id: responseData["id"],
        counter: responseData["counter"],
        limit: responseData["limit"],
      );
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }

  Future<Map<String, dynamic>> postHelpFrequency(String subject) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/notifications");
    try {
      if(_helpDetails!.counter == _helpDetails!.limit) {
        return {"success": false, "message": "Vous avez dépassé votre quota."};
      }
      if (subject == "Sujet de la demande d'aide") {
        return {"success": false, "message": "Veuillez choisir un sujet d'aide"};
      }
      final response = await http.post(
        url,
        body: jsonEncode({"subject": subject}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }
}

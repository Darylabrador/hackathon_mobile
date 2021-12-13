import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/user.dart' show User;
import '../models/team_mates.dart' show TeamMates;
import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class TeamProvider with ChangeNotifier {
  final String? authToken;
  TeamProvider({this.authToken});
  final List<TeamMates> _teamMates = [];

  Future<List<TeamMates>> getTeamMates() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/team/users");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body)['data'];
      for (var data in responseData) {
        _teamMates.add(
          TeamMates(
            id: data["id"],
            approuved: data['approuved'],
            user: User(
              id: data['user']['id'],
              email: data['user']['email'],
              surname: data['user']['surname'],
              firstname: data['user']['firstname'],
              role: data['user']['role'],
            ),
          ),
        );
      }
      notifyListeners();
      return _teamMates;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement!");
    }
  }
}

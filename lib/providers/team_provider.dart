import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../models/user.dart' show User;
import '../models/role.dart' show Role;
import '../models/team_mates.dart' show TeamMates;
import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class TeamProvider with ChangeNotifier {
  final String? authToken;
  TeamProvider({this.authToken});
  List<TeamMates> _teamMates = [];

  Role? _selectedRole;

  void setSelectedRole(Role role) {
    _selectedRole = role;
  }

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
      _teamMates = [];
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

  Future<Map<String, dynamic>> putApprouved(int id) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/team/user/$id/approbate",
    );

    try {
      final response = await http.put(
        url,
        body: null,
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

  Future<Map<String, dynamic>> putUpdateRole(int id) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/team/user/$id/role",
    );

    try {
      if (_selectedRole == null ||
          _selectedRole!.name == "0 - choisir un role") {
        return {'success': true, 'message': "Veuillez choisir un rôle"};
      }
      final response = await http.put(
        url,
        body: jsonEncode({"role": _selectedRole!.name}),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);
      _selectedRole = null;
      return responseData;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }

  Future<Map<String, dynamic>> deleteUserInTeam(int id) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/team/user/$id");

    try {
      final response = await http.delete(
        url,
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
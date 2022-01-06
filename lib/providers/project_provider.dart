import 'dart:async';
import 'dart:convert';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../models/project.dart';

class ProjectProvider with ChangeNotifier {
  final String? authToken;
  ProjectProvider({this.authToken});

  final List<Project> _projectData = [];

  List<Project> get projectData {
    return _projectData;
  }

  Future<void> getProjectData() async {
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
      _projectData.add(
        Project(name: "Quoi ?", content: responseData["what"] ?? ""),
      );
      _projectData.add(
        Project(name: "Comment ?", content: responseData["how"] ?? ""),
      );
      _projectData.add(
        Project(name: "Pour qui ?", content: responseData["for_who"] ?? ""),
      );
      _projectData.add(
        Project(
            name: "Pourquoi maintenant ?",
            content: responseData["why_now"] ?? ""),
      );
      _projectData.add(
        Project(
            name: "Qui êtes vous ?",
            content: responseData["who_are_you"] ?? ""),
      );
      _projectData.add(
        Project(name: "Pourquoi ?", content: responseData["why"] ?? ""),
      );
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez réessayer plus tard!");
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';

class InvitationProvider with ChangeNotifier {
  final String? authToken;
  InvitationProvider({this.authToken});
  String? _invitation;

  String? get invitationLink {
    return _invitation;
  }

  Future<void> getInvitation() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/invitation");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);
      _invitation = responseData['invitation'];
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez réessayer ultéreieurement");
    }
  }

  Future<void> postInvitation() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/invitation");
    try {
      final response = await http.post(
        url,
        body: null,
        headers: {
          'Content-type': 'application/json',
          'Authorization': "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);
      _invitation = responseData['invitation'];
      notifyListeners();
    } catch (e) {
      throw HttpException("Veuillez réessayer ultéreieurement");
    }
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/http_exception.dart';

class ResetPwdForgottenProvider with ChangeNotifier {
  bool _isResettingAsk = true;
  String? _resetToken;

  bool get isResettingAskForm {
    return _isResettingAsk;
  }

  void handleSwitchResetForm() {
    _isResettingAsk = !_isResettingAsk;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getForgottenResetToken({
    required String email,
  }) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/reset/ask");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "email": email,
          "isWeb": false,
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      handleSwitchResetForm();
      notifyListeners();
      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  Future<Map<String, dynamic>> updateForgottenPassword({
    required String code,
    required String password,
    required String passwordConfirm,
  }) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/reset/password");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "newPassword": password,
          "newPasswordConfirm": passwordConfirm,
          "resetToken": code,
        }),
        headers: {"Content-Type": "application/json"},
      );
      final responseData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }
      _isResettingAsk = true;
      notifyListeners();
      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}

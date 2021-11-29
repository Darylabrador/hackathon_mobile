import 'dart:async';
import 'dart:convert';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../models/http_exception.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _identity;
  DateTime? _expiryDate;
  Timer? _authTimer;


  /// retrieve identity
  String? get identity {
    if (_identity != null) return _identity;
    return "";
  }


  /// retrieve boolean about isAuth state
  bool get isAuth {
    return _token != null;
  }


  /// retrieve token
  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }


  /// function to log users
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/login");
    final autorizedRoles = [];
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'email': email.trim(), 'password': password.trim()}),
        headers: {"Content-Type": "application/json"},
      );
      final responseData = jsonDecode(response.body);
      if (autorizedRoles.contains(responseData["role"])) {
        if (responseData['success']) {
          _identity = responseData['identity'];
          _token = responseData['token'];
          _expiryDate = JwtDecoder.getExpirationDate(responseData["token"]);
          await _setSharedPreferences(_token, _expiryDate, _identity);
          notifyListeners();
          _autoLogout();
        }
        return responseData;
      } else {
        var message = responseData["token"] != null
            ? "Vous n'êtes pas autorisé à vous connecter"
            : responseData["message"];
        return {'success': false, 'message': message};
      }
    } catch (e) {
      throw HttpException("Veuillez rééssayez ultérieurement!");
    }
  }


  /// function to set sharedpreference in the app
  Future<void> _setSharedPreferences(
    String? token,
    DateTime? expiryDate,
    String? identity,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode({
      "identity": identity,
      "token": token,
      "expiryDate": expiryDate!.toIso8601String(),
    });
    await prefs.setString("userData", userData);
  }


  /// function to try auto login user depending on sharedpreferences
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) return false;

    final extractData = jsonDecode(prefs.getString("userData")!) as Map<String, Object>;
    final expiryData = DateTime.parse(extractData['expiryDate'] as String);
    if (expiryData.isBefore(DateTime.now())) return false;

    _expiryDate = expiryData;
    _token = extractData["token"] as String;
    _identity = extractData["identity"] as String;
    notifyListeners();
    _autoLogout();
    return true;
  }


  /// function to logout users
  Future<void> logout() async {
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    _token = null;
    _expiryDate = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
  }


  /// function to set timer to auto logout user when token expired
  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();
    final timeToExpired = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpired), logout);
  }
}
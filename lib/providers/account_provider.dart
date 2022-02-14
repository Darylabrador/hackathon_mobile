import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:hackathon_mobile_app/utils/constant_variables.dart';

import '../models/http_exception.dart';

class AccountProvider with ChangeNotifier {
  final String? authToken;
  AccountProvider({this.authToken});

  // get account informations
  Future<Map<String, dynamic>> getInfoAccount() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/informations");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData["data"];
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  // update account
  Future<Map<String, dynamic>> updateAccount({
    required String email,
    required String surname,
    required String firstname,
    required int gender,
    required int age,
  }) async {
    final url =
        Uri.parse("${ConstantVariables.startingURL}/account/informations");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'email': email,
          'surname': surname,
          'firstname': firstname,
          'gender': gender,
          'age': age,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  // update password
  Future<Map<String, dynamic>> updatePassword({
    required String oldPassword,
    required String password,
    required String passwordConfirm,
  }) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/account/password");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'oldPassword': oldPassword,
          'password': password,
          'passwordConfirm': passwordConfirm,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }

  // delete account
  Future<Map<String, dynamic>> deleteAccount({
    required String password,
    required String passwordConfirm,
  }) async {
    final url = Uri.parse("${ConstantVariables.startingURL}/account/delete");
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          "password": password,
          "passwordConfirm": passwordConfirm,
        }),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      return responseData;
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}

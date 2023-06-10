import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nanohealth_task/utils/snackbar/snackbar.dart';

import '../../utils/constants/constants.dart';

class AuthenticationService extends ChangeNotifier {
  bool isLoading = false;
  String? authToken;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (email == "") {
      failureSnackbar("Email address cannot be empty");
    } else if (password == "") {
      failureSnackbar("Password cannot be empty");
    } else {
      await checkEmailPassword(email, password, context).then((value) {
        authToken = value;
        if (value == null) {
          failureSnackbar("User not found");
        }
        isLoading = false;
        notifyListeners();
      });
    }

    isLoading = false;
    notifyListeners();
  }

  Future<String?> checkEmailPassword(
      String email, String password, BuildContext context) async {
    String? token;
    var url = Uri.parse('${Constants.API_URL}auth/login');
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(response.body);
      token = responseJson["token"];
    }

    return token;
  }
}

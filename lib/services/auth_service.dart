import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier{
  final String baseUrl = "identitytoolkit.googleapis.com";
  final String _fireBaseToken = "AIzaSyAMaGIyv6aQTiA1vq2D6WqC1pTesAg2h8o";
  final storage = const FlutterSecureStorage();

  Future<String?> createUser({required String email, required String password}) async {
    final Map<String, dynamic> authData = {'email': email, 
                                          'password': password,
                                          'returnSecureToken': true};
    
    final url = Uri.https(baseUrl, "/v1/accounts:signUp", {
      "key": _fireBaseToken
    });

    final response = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedData = jsonDecode(response.body);

    if(decodedData.containsKey("idToken")) {
      
      await storage.write(key: "token", value: decodedData["idToken"]);

      return null;
    }
    else{
      return decodedData['error']['message'];
    }
  }

  Future<String?> login({required String email, required String password}) async {
    final Map<String, dynamic> authData = {'email': email, 
                                          'password': password,
                                          'returnSecureToken': true};
    
    final url = Uri.https(baseUrl, "/v1/accounts:signInWithPassword", {
      "key": _fireBaseToken
    });

    final response = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedData = jsonDecode(response.body);

    if(decodedData.containsKey("idToken")) {
      await storage.write(key: "token", value: decodedData["idToken"]);

      return null;
    }
    else{
      return decodedData['error']['message'];
    }
  }

  Future logOut() async {
    await storage.delete(key: "token");
  }

  Future<String> readToken() async {
    return await storage.read(key: "token") ?? "";
  }
}
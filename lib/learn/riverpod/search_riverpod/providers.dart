import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final getUserProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
  final jsonResponse = jsonDecode(response.body);
  return jsonResponse;
});

final searchUserProvider = StateProvider<String>((ref) => '');

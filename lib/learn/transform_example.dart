import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TransformExample extends StatefulWidget {
  const TransformExample({super.key});

  @override
  State<TransformExample> createState() => _TransformExampleState();
}

class _TransformExampleState extends State<TransformExample> {
  Future<List<UserModel>> getAllTodo() async {
    try {
      final response =
          await http.get(Uri.parse("https://reqres.in/api/users?page=2"));

      log("RESPONSE: ${response.body} -- ${response.statusCode}");

      final decodeData = jsonDecode(response.body);

      final users = [
        for (final user in decodeData["data"]) UserModel.fromMap(user)
      ];

      return users;
    } catch (e, st) {
      log("ERROR FROM FETCH ALL TODOS: $e $st");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mutation"),
        ),
        body: FutureBuilder(
          future: getAllTodo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Center(
                child: Text("Data"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ));
  }
}

class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map["id"],
        email: map["email"],
        lastName: map["last_name"],
        firstName: map["first_name"]);
  }
}

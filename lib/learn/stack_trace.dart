// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StackTraceExample extends StatefulWidget {
  const StackTraceExample({super.key});

  @override
  State<StackTraceExample> createState() => _StackTraceExampleState();
}

class _StackTraceExampleState extends State<StackTraceExample> {
  Future<List<ProductModel>> fetchData() async {
    try {
      List<ProductModel> temp = [];

      final response =
          await http.get(Uri.parse("https://dummyjson.com/products"));

      final decode = jsonDecode(response.body);

      for (final item in decode["products"]) {
        temp.add(ProductModel.fromMap(item));
      }

      return temp;
    } catch (e, st) {
      log("ERROR FETCH DATA $e $st");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stack Trace Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 18,
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          snapshot.data![index].title,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ));
                }
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ProductModel {
  final int id;
  final String title;
  final String description;
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LearnSearch extends StatefulWidget {
  const LearnSearch({super.key});

  @override
  State<LearnSearch> createState() => _LearnSearchState();
}

class _LearnSearchState extends State<LearnSearch> {
  bool _isLoading = false;
  final List _user = [];
  final List _searchUser = [];

  final searchC = TextEditingController();

  void searchUser(String text) {
    if (text.isNotEmpty) {
      final user = _user
          .where((element) => element['email']
              .toString()
              .toLowerCase()
              .contains(text.toLowerCase()))
          .toSet()
          .toList();
      if (user.isNotEmpty) {
        _searchUser.addAll(user);
      }
      setState(() {});
    }
  }

  Future getData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final resp =
          await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
      final jsonResp = jsonDecode(resp.body);
      _user.addAll(jsonResp['data']);

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      log('ERROR $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    await getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Search'),
      ),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: TextFormField(
                controller: searchC,
                onChanged: (value) {
                  if (value.isEmpty) _searchUser.clear();
                  setState(() {});
                },
                onEditingComplete: () => searchUser(searchC.text),
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
          ),
          _isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                  itemCount: _searchUser.isNotEmpty
                      ? _searchUser.length
                      : _user.length,
                  itemBuilder: (context, index) {
                    final user = _searchUser.isNotEmpty
                        ? _searchUser[index]
                        : _user[index];
                    return ListTile(
                      title: Text('${user['first_name']} ${user['last_name']}'),
                      subtitle: Text(user['email']),
                      leading: CircleAvatar(
                        maxRadius: 30,
                        backgroundImage: NetworkImage(user['avatar']),
                      ),
                    );
                  },
                )),
        ],
      ),
    );
  }
}

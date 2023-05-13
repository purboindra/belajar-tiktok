import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DropdownLearn extends StatefulWidget {
  const DropdownLearn({super.key});

  @override
  State<DropdownLearn> createState() => _DropdownLearnState();
}

class _DropdownLearnState extends State<DropdownLearn> {
  bool _isLoading = false;
  final List<DropdownMenuItem> _listDropdown = [];

  Future getData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final resp =
          await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
      final jsonResp = jsonDecode(resp.body);
      for (final item in jsonResp['data']) {
        _listDropdown.add(
          DropdownMenuItem(
            value: item['first_name'],
            child: Text(item['first_name']),
          ),
        );
      }
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

  final List<DropdownMenuItem> _itemDropdown = [
    const DropdownMenuItem(
      value: 'johanliebert@gmail.com',
      child: Text('johanliebert@gmail.com'),
    ),
    const DropdownMenuItem(
      value: 'williammm@gmail.com',
      child: Text('williammm@gmail.com'),
    ),
    const DropdownMenuItem(
      value: 'thisisino@gmail.com',
      child: Text('thisisino@gmail.com'),
    ),
    const DropdownMenuItem(
      value: 'helloperkins@gmail.com',
      child: Text('helloperkins@gmail.com'),
    ),
  ];

  String? _newVal;

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
        title: const Text('Belajar Dropdown'),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : DropdownButton(
                value: _newVal ?? _listDropdown[0].value,
                items: _listDropdown,
                onChanged: (value) {
                  _newVal = value;
                  setState(() {});
                },
              ),
      ),
    );
  }
}

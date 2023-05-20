import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LearnSearch extends StatefulWidget {
  const LearnSearch({super.key});

  @override
  State<LearnSearch> createState() => _LearnSearchState();
}

class _LearnSearchState extends State<LearnSearch> {
  bool _isLoading = false;
  final List _user = [];
  final List _searchUser = [];
  List<String> listHistoryForPrefs = [];
  final searchC = TextEditingController();
  bool _isFocus = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _getData();
    _getHistorySearch();
  }

  void _onUnFocusChange() {
    _focusNode.unfocus();
    _isFocus = false;
    setState(() {});
  }

  void _onFocusChange() {
    _isFocus = true;
    setState(() {});
  }

  void _getData() async {
    await getData();
  }

  void _getHistorySearch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    listHistoryForPrefs
        .addAll(preferences.getStringList('historySearch') ?? []);
  }

  void _deleteHistorySearch(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final isOnSearch =
        listHistoryForPrefs.indexWhere((element) => element == searchC.text);
    if (isOnSearch != -1) {
      searchC.clear();
      _searchUser.clear();
    }
    listHistoryForPrefs.removeAt(index);
    preferences.setStringList('historySearch', listHistoryForPrefs);

    setState(() {});
  }

  void searchUser(String text) async {
    _searchUser.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
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
        if (listHistoryForPrefs.length <= 5) {
          if (!listHistoryForPrefs.contains(text)) {
            listHistoryForPrefs.insert(0, text);
            final list = listHistoryForPrefs.toSet().toList();
            preferences.setStringList('historySearch', list);
            setState(() {});
          }
        }
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onUnFocusChange(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Belajar Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: TextFormField(
                  onTap: () {
                    _onFocusChange();
                  },
                  focusNode: _focusNode,
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
              const SizedBox(
                height: 10,
              ),
              if (_isFocus == true && listHistoryForPrefs.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Terakhir Dicari'),
                    const SizedBox(
                      height: 7,
                    ),
                    Wrap(
                      children: List.generate(
                        listHistoryForPrefs.length,
                        (index) => InkWell(
                          onTap: () {
                            searchC.text = listHistoryForPrefs[index];
                            searchUser(searchC.text);
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5, top: 3),
                            child: Chip(
                              onDeleted: () => _deleteHistorySearch(index),
                              deleteIconColor: Colors.black,
                              deleteIcon: const Icon(
                                Icons.cancel,
                                size: 14,
                              ),
                              label: Text(listHistoryForPrefs[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: _searchUser.isNotEmpty
                          ? _searchUser.length
                          : _user.length,
                      itemBuilder: (context, index) {
                        final user = _searchUser.isNotEmpty
                            ? _searchUser[index]
                            : _user[index];
                        return ListTile(
                          title: Text(
                              '${user['first_name']} ${user['last_name']}'),
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
        ),
      ),
    );
  }
}

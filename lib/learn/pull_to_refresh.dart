import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PullToRefreshExample extends StatefulWidget {
  const PullToRefreshExample({super.key});

  @override
  State<PullToRefreshExample> createState() => _PullToRefreshExampleState();
}

class _PullToRefreshExampleState extends State<PullToRefreshExample> {
  int _pageId = 1;

  bool _isLoading = false;

  late RefreshController _refreshController;

  Map<String, dynamic> userData = {};

  Future<void> getAllUser() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http
          .get(Uri.parse("https://reqres.in/api/users?page=$_pageId"));
      final decodeResponse = jsonDecode(response.body);
      userData.addAll(decodeResponse);
      if (mounted) {
        setState(() {});
      }
      _refreshController.refreshCompleted();
    } finally {
      await Future.delayed(const Duration(milliseconds: 700), () {
        _isLoading = false;
      });

      setState(() {});
    }
  }

  void _onRefresh() async {
    _pageId += 1;
    if (_pageId == 3) {
      _pageId = 1;
      setState(() {});
    }
    getUser();
    _refreshController.loadComplete();
  }

  void getUser() async {
    await getAllUser();
  }

  @override
  void initState() {
    _refreshController = RefreshController(initialRefresh: false);
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pull To Refresh'),
      ),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 18,
                ),
                child: userData["data"].isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : ListView.builder(
                        itemCount: userData["data"].length,
                        itemBuilder: (context, index) {
                          final user = userData["data"][index];
                          return ListTile(
                            title: Text(
                              user["first_name"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              user["email"],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            leading: ClipOval(
                              child: Image.network(
                                user["avatar"],
                                width: 26,
                                height: 26,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
    );
  }
}

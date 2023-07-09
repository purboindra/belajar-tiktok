import 'package:belajar_tiktok/learn/riverpod/search_riverpod/providers.dart';
import 'package:belajar_tiktok/learn/riverpod/search_riverpod/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUserRiverpod extends ConsumerWidget {
  const SearchUserRiverpod({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAllUser = ref.watch(getUserProvider);
    final searchText = ref.watch(searchUserProvider);
    final searchController = ref.watch(searchControllerProvider);

    return GestureDetector(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Search Features Riverpod'),
          ),
          body: getAllUser.when(
            data: (data) => Form(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          ref
                              .read(searchUserProvider.notifier)
                              .update((state) => state = value);
                        },
                        onEditingComplete: () {
                          ref
                              .read(searchControllerProvider.notifier)
                              .onSearchUser(searchText, data['data']);
                        },
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
                    Expanded(
                        child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: searchController.isNotEmpty
                          ? searchController.length
                          : data['data'].length,
                      itemBuilder: (context, index) {
                        final user = searchController.isNotEmpty
                            ? searchController[index]
                            : data['data'][index];
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
            error: (error, stackTrace) => const SizedBox(
              height: double.infinity,
              child: Center(
                child: Text('Something went wrong'),
              ),
            ),
            loading: () => const SizedBox(
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )),
    );
  }
}

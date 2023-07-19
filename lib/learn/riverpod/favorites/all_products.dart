import 'dart:developer';

import 'package:belajar_tiktok/learn/riverpod/favorites/favorite_controller.dart';
import 'package:belajar_tiktok/learn/riverpod/favorites/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allProduct = ref.watch(getAllProductsProvider);
    final listFav = ref.watch(listFavProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: allProduct.when(
        data: (data) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20, crossAxisCount: 2),
                itemBuilder: (context, index) => Card(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.network(
                              data[index]['image'],
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: data[index]['isFavorite']
                                  ? () {
                                      ref
                                          .read(listFavProvider.notifier)
                                          .removeFromFav(data[index]['id']);
                                    }
                                  : () {
                                      ref
                                          .read(listFavProvider.notifier)
                                          .addToFav(index, data);
                                    },
                              icon: data[index]['isFavorite']
                                  ? const Icon(
                                      Icons.favorite,
                                      size: 32,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_outline,
                                      size: 32,
                                      color: Colors.grey.shade600,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data[index]['title']),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        error: (error, stackTrace) => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('error $error'),
            ),
          ],
        ),
        loading: () => Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          for (final item in listFav) {
            log('ITEM IN CARD $item');
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.favorite,
                size: 32,
              ),
              Align(
                alignment: Alignment.topRight,
                child: ClipOval(
                  child: Container(
                    width: 22,
                    height: 22,
                    color: Colors.red,
                    child: Center(
                      child: Text(listFav.length.toString()),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

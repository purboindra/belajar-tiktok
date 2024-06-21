import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CachedNetworkImageExample extends StatefulWidget {
  const CachedNetworkImageExample({super.key});

  @override
  State<CachedNetworkImageExample> createState() =>
      _CachedNetworkImageExampleState();
}

class _CachedNetworkImageExampleState extends State<CachedNetworkImageExample> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _products = [];

  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await http.get(Uri.parse("https://dummyjson.com/products"));

      if (response.statusCode != 200) throw Exception("Something went wrong!");

      final data = jsonDecode(response.body);

      _products = List<Map<String, dynamic>>.from(data["products"]);
    } catch (e) {
      log("ERROR GET PRODUCTS: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void callGetProduct() async {
    await getData();
  }

  @override
  void initState() {
    callGetProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cached Network Image"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailProduct(product: product),
                                )),
                            title: Text(
                              product["title"],
                            ),
                            subtitle: Text(product["description"]),
                            leading: CachedNetworkImage(
                              imageUrl: product["thumbnails"],
                              imageBuilder: (context, imageProvioder) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvioder,
                                        fit: BoxFit.fill),
                                  ),
                                );
                              },
                              placeholder: (context, url) => const SizedBox(
                                height: 250,
                                width: 164,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product["title"]),
      ),
    );
  }
}

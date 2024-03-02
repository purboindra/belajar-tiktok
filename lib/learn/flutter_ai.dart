import 'dart:developer';

import 'package:belajar_tiktok/main.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class FlutterGeminiExample extends StatefulWidget {
  const FlutterGeminiExample({super.key});

  @override
  State<FlutterGeminiExample> createState() => _FlutterGeminiExampleState();
}

class _FlutterGeminiExampleState extends State<FlutterGeminiExample> {
  GenerativeModel? model;
  final _promptController = TextEditingController();
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  }

  @override
  void dispose() {
    super.dispose();
    _promptController.dispose();
  }

  Future<void> loadResponse() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final content = [Content.text(_promptController.text)];
      final response = await model!.generateContent(content);
      data = [
        ...data,
        {"question": _promptController.text, "answer": response.text}
      ];

      setState(() {});
    } catch (e) {
      log("ERROR $e");
      throw Exception("Sorry something went wrong!");
    } finally {
      _isLoading = false;
      _promptController.clear();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500), curve: Curves.bounceIn);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Integration"),
        backgroundColor: Colors.black26,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (data.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      "Hello, AI Integration Example",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              if (data.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: data.length,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    itemBuilder: (context, index) {
                      if (data[index]["question"] != null &&
                          data[index]["answer"] != null) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.purple.shade800,
                                ),
                                child: Text(
                                  data[index]["question"] ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue.shade800,
                                ),
                                child: Text(
                                  data[index]["answer"] ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
            ],
          ),
          if (_isLoading)
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
              ),
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 100,
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(maxHeight: 80),
                    child: SingleChildScrollView(
                      child: TextFormField(
                        maxLines: null,
                        controller: _promptController,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            hintText: "Write a prompt..."),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () async => loadResponse(),
                  icon: const Icon(
                    Icons.send,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

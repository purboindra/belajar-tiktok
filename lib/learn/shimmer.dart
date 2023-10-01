import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LearnShimmer extends StatefulWidget {
  const LearnShimmer({super.key});

  @override
  State<LearnShimmer> createState() => _LearnShimmerState();
}

class _LearnShimmerState extends State<LearnShimmer> {
  bool _isLoading = true;

  final List<Map<String, dynamic>> platform = [
    {
      'imageUrl': 'assets/medium.png',
      'label': 'purboyndra',
      'baseColor': Colors.black,
      'highlightColor': Colors.white,
    },
    {
      'imageUrl': 'assets/youtube.png',
      'label': '@purboyndra',
      'baseColor': Colors.red.shade600,
      'highlightColor': Colors.white
    },
    {
      'imageUrl': 'assets/tiktok.png',
      'label': '@purboyndra',
      'baseColor': Colors.black,
      'highlightColor': Colors.white,
    },
  ];
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 5),
      () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn Shimmer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isLoading) ...[
              Expanded(
                  child: ListView.builder(
                itemCount: platform.length,
                itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: platform[index]['baseColor'],
                  ),
                  child: Shimmer.fromColors(
                    baseColor: platform[index]['baseColor'] as Color,
                    highlightColor: platform[index]['highlightColor'] as Color,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Image.asset(
                              platform[index]['imageUrl'],
                              color: Colors.white,
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              platform[index]['label'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ))
            ] else ...[
              Expanded(
                  child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  height: 70,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade500,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ))
            ]
          ],
        ),
      ),
    );
  }
}

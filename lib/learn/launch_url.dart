import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl extends StatelessWidget {
  const LaunchUrl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Launch Url'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('https://youtube.com/@purboyndra');
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    }
                  },
                  child: const Text('Show Youtube')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final url = Uri.parse('https://tiktok.com/@purboyndra');
                    if (await canLaunchUrl(url)) {
                      launchUrl(url);
                    }
                  },
                  child: const Text('Show Tiktok')),
            ],
          ),
        ),
      ),
    );
  }
}

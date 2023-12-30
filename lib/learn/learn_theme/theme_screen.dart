import 'package:belajar_tiktok/learn/learn_theme/theme_controller.dart';
import 'package:belajar_tiktok/learn/stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatelessWidget {
  ThemeScreen({super.key});

  final _themeC = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
            () => Text(_themeC.isDarkMode.isTrue ? "Dark Mode" : "Light Mode")),
      ),
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tap on the switch to change the Theme",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:
                      _themeC.isDarkMode.isFalse ? Colors.black : Colors.white,
                ),
              ),
              Switch(
                  value: _themeC.isDarkMode.value,
                  onChanged: (value) {
                    _themeC.isDarkMode.toggle();
                    Get.changeThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light);
                  },
                  activeColor: Colors.purple),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LearnStepper(),
                  ));
                },
                child: const Text(
                  "Route to",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

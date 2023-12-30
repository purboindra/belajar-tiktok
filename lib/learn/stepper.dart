import 'package:belajar_tiktok/learn/learn_theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearnStepper extends StatefulWidget {
  const LearnStepper({super.key});

  @override
  State<LearnStepper> createState() => _LearnStepperState();
}

class _LearnStepperState extends State<LearnStepper> {
  int index = 0;

  final ThemeController _themeController = Get.find();

  List<Step> step() {
    return [
      Step(
        title: Text(
          "Your Package has Arrived in Tangerang",
          style: TextStyle(
            fontSize: 18,
            fontWeight: index == 0 ? FontWeight.bold : FontWeight.w500,
            color: index == 0
                ? _themeController.isDarkMode.isTrue
                    ? Colors.white
                    : Colors.black
                : Colors.grey.shade600,
          ),
        ),
        content: Container(
          color: Colors.red,
        ),
        isActive: index == 0,
        state: index > 0 ? StepState.complete : StepState.indexed,
        subtitle: Text(
          "Your package has dropped at Tangerang",
          style: TextStyle(
            fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w400,
            color: index == 0
                ? _themeController.isDarkMode.isTrue
                    ? Colors.white
                    : Colors.black
                : Colors.grey.shade600,
          ),
        ),
      ),
      Step(
        title: Text(
          "Your Package is in Transit",
          style: TextStyle(
            fontSize: 18,
            fontWeight: index == 1 ? FontWeight.bold : FontWeight.w500,
            color: index == 1 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        content: const SizedBox(),
        isActive: index == 1,
        state: index > 1 ? StepState.complete : StepState.indexed,
        subtitle: Text(
          "Your package is in transit DC Cakung",
          style: TextStyle(
            fontWeight: index == 1 ? FontWeight.w600 : FontWeight.w400,
            color: index == 1 ? Colors.black : Colors.grey.shade600,
          ),
        ),
      ),
      Step(
        title: Text(
          "Package Picked",
          style: TextStyle(
            fontSize: 18,
            fontWeight: index == 2 ? FontWeight.bold : FontWeight.w500,
            color: index == 2 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        content: const SizedBox(),
        isActive: index == 2,
        subtitle: Text(
          "Your products has been picked",
          style: TextStyle(
            fontWeight: index == 2 ? FontWeight.w600 : FontWeight.w400,
            color: index == 2 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        state: index > 2 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          "Products Waiting for Courier",
          style: TextStyle(
            fontSize: 18,
            fontWeight: index == 3 ? FontWeight.bold : FontWeight.w500,
            color: index == 3 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        content: const SizedBox(),
        isActive: index == 3,
        subtitle: Text(
          "Your order waiting for pick up by courier!",
          style: TextStyle(
            fontWeight: index == 3 ? FontWeight.w600 : FontWeight.w400,
            color: index == 3 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        state: index > 3 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          "Order Placed",
          style: TextStyle(
            fontSize: 18,
            fontWeight: index == 4 ? FontWeight.bold : FontWeight.w500,
            color: index == 4 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        content: const SizedBox(),
        isActive: index == 4,
        subtitle: Text(
          "Your order has been placed!",
          style: TextStyle(
            fontWeight: index == 4 ? FontWeight.w600 : FontWeight.w400,
            color: index == 4 ? Colors.black : Colors.grey.shade600,
          ),
        ),
        state: index > 4 ? StepState.complete : StepState.indexed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stepper')),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 22,
              ),
              child: Stepper(
                currentStep: index,
                stepIconBuilder: (stepIndex, stepState) {
                  if (stepIndex == index) {
                    return Container(
                      height: 32,
                      width: 32,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(width: 2, color: Colors.blue),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      ),
                    );
                  }

                  switch (stepState) {
                    case StepState.complete:
                    case StepState.editing:
                    case StepState.indexed:
                      return Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                      );
                    case StepState.disabled:
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      );
                    default:
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                      );
                  }
                  return null;
                },
                connectorThickness: 3,
                margin: EdgeInsets.zero,
                connectorColor: const MaterialStatePropertyAll(Colors.blue),
                controlsBuilder: (context, details) {
                  if (details.currentStep == index) {
                    return const Row(
                      children: [
                        SizedBox(),
                        SizedBox(),
                      ],
                    );
                  }
                  return const SizedBox();
                },
                onStepCancel: () {
                  if (index > 0) {
                    index--;
                    setState(() {});
                  }
                },
                onStepContinue: () {
                  index++;
                  setState(() {});
                },
                onStepTapped: (int idx) {
                  setState(() {
                    index = idx;
                  });
                },
                steps: step(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

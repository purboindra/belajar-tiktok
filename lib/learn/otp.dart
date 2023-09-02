import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<TextEditingController> otpForm =
      List.generate(4, (index) => TextEditingController());
  bool isEmptyField = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Otp Form Field'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  otpForm.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width / 5,
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      controller: otpForm[index],
                      textAlign: TextAlign.center,
                      onChanged: (val) {
                        isEmptyField =
                            otpForm.any((element) => element.text == '');
                        if (val.isNotEmpty) {
                          FocusScope.of(context).nextFocus();
                        } else {
                          FocusScope.of(context).previousFocus();
                        }
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
                    vertical: 12,
                  )),
                  backgroundColor: MaterialStatePropertyAll(
                      !isEmptyField ? Colors.blue : Colors.grey),
                  minimumSize: MaterialStatePropertyAll<Size>(
                    Size(MediaQuery.of(context).size.width, 30),
                  ),
                ),
                onPressed: () {},
                child: const Text('Oke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

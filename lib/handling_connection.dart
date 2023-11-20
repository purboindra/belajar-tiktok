import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

final isConnectProvider = StateProvider<bool>((ref) {
  return false;
});

class HandlingConnection extends ConsumerStatefulWidget {
  const HandlingConnection({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HandlingConnectionState();
}

class _HandlingConnectionState extends ConsumerState<HandlingConnection> {
  late StreamSubscription connectionSubscription;

  @override
  void dispose() {
    connectionSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initConnectivity();
    connectionSubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnection);
  }

  void _initConnectivity() async {
    await initConnectivity();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult? connectivityResult;
    try {
      connectivityResult = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      log("ERROR FROM INIT CONNECTIVITY $e");
      connectivityResult = ConnectivityResult.none;
    }
    return _updateConnection(connectivityResult);
  }

  Future<void> _updateConnection(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        ref.watch(isConnectProvider.notifier).update((state) => true);
        break;
      default:
        ref.watch(isConnectProvider.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isConnect = ref.watch(isConnectProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connection Handler"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isConnect) ...[
              _buildConnected(),
            ] else ...[
              _buildLostConnection(),
            ],
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: isConnect
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Button Login Tapped")));
                      }
                    : null,
                child: const Text("Login")),
          ],
        ),
      ),
    );
  }

  Text _buildConnected() {
    return const Text(
      "Terhubung ke Internet",
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Column _buildLostConnection() {
    return Column(
      children: [
        Lottie.asset(
          "assets/no_internet.json",
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Koneksi Anda Terputus...",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

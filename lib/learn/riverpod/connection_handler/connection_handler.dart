import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

final connectivityResultProvider = StateProvider<ConnectivityResult>((ref) {
  return ConnectivityResult.none;
});

final isConnected = StateProvider<bool>((ref) {
  return false;
});

class ConnectionHandler extends ConsumerStatefulWidget {
  const ConnectionHandler({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConnectionHandlerState();
}

class _ConnectionHandlerState extends ConsumerState<ConnectionHandler> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      ref.read(connectivityResultProvider.notifier).update((state) => result);
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    ref.watch(connectivityResultProvider.notifier).update((state) => result);
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        ref.watch(isConnected.notifier).update((state) => true);
        break;
      case ConnectivityResult.none:
        ref.watch(isConnected.notifier).update((state) => false);
        break;
      default:
        ref.watch(isConnected.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectionStatus = ref.watch(connectivityResultProvider);
    final isConnect = ref.watch(isConnected);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Handler'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: isConnect
              ? _connectedWidget(context, connectionStatus)
              : _noInternetWidget(context),
        ),
      ),
    );
  }

  Column _connectedWidget(
      BuildContext context, ConnectivityResult connectivityResult) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Terhubung ke Internet $connectivityResult",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Column _noInternetWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 300,
          width: MediaQuery.of(context).size.width,
          child: Lottie.asset(
            'assets/no_internet.json',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Tidak Terhubung ke Internet",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

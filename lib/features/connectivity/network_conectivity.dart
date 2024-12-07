import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class $NetworkConectivity {
  const $NetworkConectivity();
  Future<bool> isConnected();
  Stream<bool> connectionChecking();
}

@immutable
class NetworkConectivity extends $NetworkConectivity {
  final Connectivity _connectivity;

  const NetworkConectivity({required Connectivity connectivity})
      : _connectivity = connectivity;
  @override
  Stream<bool> connectionChecking() {
    try {
      return _connectivity.onConnectivityChanged.map((e) => e.any((result) =>
          (result == ConnectivityResult.mobile) ||
          result == ConnectivityResult.wifi));
    } on PlatformException catch (_) {
      return Stream.error("Network is not available");
    }
  }

  @override
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      return result.any((result) =>
          (result == ConnectivityResult.mobile) ||
          result == ConnectivityResult.wifi);
    } catch (e) {
      return false;
    }
  }
}

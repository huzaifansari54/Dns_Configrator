import 'dart:async';

import 'package:dns_configurator/core/extensions/types.dart';
import 'package:dns_configurator/features/connectivity/network_conectivity.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platform_interface.dart';
import 'package:dns_configurator/features/logger/logger.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;
import '../../../locator.dart';
import 'state.dart' as s;

final stateProvider = StateNotifierProvider<StateController, s.State>(
    (_) => StateController(lc(), lc(), lc()));

class StateController extends StateNotifier<s.State> {
  final PlatformInterface _platformInterface;
  final ILogger _logger;
  final $NetworkConectivity _conectivity;
  late final StreamSubscription<bool> _subscription;
  StateController(this._platformInterface, this._logger, this._conectivity)
      : super(s.State.init()) {
    loadLogs();
    _subscription = _conectivity
        .connectionChecking()
        .listen((e) => state = state.copyWith(isNetwork: e));
  }
  bool isActive(String dns) =>
      state.logs.firstWhere((test) => test.dsaAddress == dns).isActive;

  dnsChanged(String dns) => state = state.copyWith(dnsAdress: dns);

  onIsActive(String dns) async {
    if (isActive(dns)) {}
    state = state.copyWith(loading: true);
    final resultOrFailure = await _platformInterface.stopDns(dns: dns).run();
    resultOrFailure.match((failure) => state = state.copyWith(loading: false),
        (data) {
      state = state.copyWith(loading: false);
      loadLogs();
    });
  }

  loadLogs() =>
      state = state.copyWith(logs: _logger.getLogs().reversed.toList());

  void modifyDns(BuildContext context) async {
    state = state.copyWith(loading: true);
    final resultOrFailure =
        await _platformInterface.modifiyDNS(dns: state.dnsAdress).run();
    resultOrFailure.match((failure) {
      state = state.copyWith(error: "Some thing went", loading: false);
      context.snackbar(failure.failure.toString());
    }, (_) {
      state = state.copyWith(loading: false);
      loadLogs();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

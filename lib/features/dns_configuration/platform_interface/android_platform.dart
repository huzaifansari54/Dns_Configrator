import 'dart:io';

import 'package:dns_configurator/core/constants/constants.dart';
import 'package:dns_configurator/core/exception/platform_exception.dart';
import 'package:flutter/services.dart';

import 'platforms.dart';

class AndroidPlatform extends Platforms {
  static const MethodChannel _channel = MethodChannel(Constant.channel);

  @override
  Future<void> modifie({required String dns}) async {
    try {
      final result = await AndroidPlatform._channel
          .invokeMethod(Constant.startMethod, {'dns': dns});
      print(result);
    } catch (e) {
      throw AndroidException();
    }
  }

  @override
  Future<void> stop({required String dns}) async {
    try {
      final result = await AndroidPlatform._channel
          .invokeMethod(Constant.stopMethod, {'dns': dns});
      print(result);
    } catch (e) {
      throw AndroidException();
    }
  }
}

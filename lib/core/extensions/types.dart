import 'dart:io';
import 'package:dns_configurator/core/constants/constants.dart';
import 'package:dns_configurator/core/theme/theme.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/linux_platform.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/mac_platform.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platforms.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/window_platform.dart';
import 'package:dns_configurator/features/dns_configuration/state_controller/state_controller.dart';
import 'package:dns_configurator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/dns_configuration/platform_interface/android_platform.dart';

extension $BuildContext on BuildContext {
  void snackbar(String content) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(content)));
  }

  Brightness getTheme() => Theme.of(this).brightness;
}

extension $String on String {
  bool isValidIPAddress() => isNotEmpty ? Constant.ipRgx.hasMatch(this) : false;
}

extension $DateTime on DateTime {
  String toDateTime() => "$hour:$minute:$second";
  static int _hour(String time) => int.parse(time.split(":")[0]);
  static int _min(String time) => int.parse(time.split(":")[1]);
  static int _sec(String time) => int.parse(time.split(":")[2]);

  static DateTime fromDateTime(String time) => DateTime.now()
      .copyWith(hour: _hour(time), second: _sec(time), minute: _min(time));
}

extension $Platform on Platform {
  static Platforms platforms() {
    if (Platform.isAndroid) return lc<AndroidPlatform>();
    if (Platform.isLinux) return lc<LinuxPlatform>();
    if (Platform.isMacOS) return lc<MacPlatform>();
    if (Platform.isWindows) return lc<WindowPlatform>();
    throw UnimplementedError("this platform is not supported yet");
  }
}

extension $WidgetRef on WidgetRef {
  setTheme(BuildContext context) =>
      read(themeProvider.notifier).setTheme(context);
  loadlogs() => read(stateProvider.notifier).loadLogs();
  onIsActivityChanged(String dns) =>
      read(stateProvider.notifier).onIsActive(dns);
  isActive(String dns) => read(stateProvider.notifier).isActive(dns);

  onDnsChanged(String dns) => read(stateProvider.notifier).dnsChanged(dns);
  onUpdateDns(BuildContext context) =>
      read(stateProvider.notifier).modifyDns(context);
}

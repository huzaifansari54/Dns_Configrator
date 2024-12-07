import 'package:dns_configurator/core/constants/constants.dart';
import 'package:dns_configurator/core/exception/platform_exception.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platforms.dart';
import 'dart:io';

class LinuxPlatform extends Platforms {
  @override
  Future<void> modifie({required String dns}) async {
    try {
      final result =
          await Process.run(Constant.linuxCommand, Constant.linuxArg(dns));
      if (result.exitCode != 0) throw LinuxException();
    } catch (e) {
      throw LinuxException();
    }
  }
}

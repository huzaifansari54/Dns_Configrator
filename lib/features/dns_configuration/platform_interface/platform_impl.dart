import 'dart:convert';

import 'package:dns_configurator/core/extensions/types.dart';
import 'package:dns_configurator/features/dns_configuration/model/model.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platform_interface.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platforms.dart';
import 'package:dns_configurator/features/logger/logger.dart';
import 'package:fpdart/fpdart.dart';
import '../../../core/exception/failures.dart';
import '../../../core/exception/platform_exception.dart';

class PlatformImpl implements PlatformInterface {
  final Platforms platforms;
  final ILogger logger;

  PlatformImpl(this.logger) : platforms = $Platform.platforms();
  PlatformImpl.fromPlatForm(this.platforms, this.logger);

  @override
  TaskEither<Failures, Unit> modifiyDNS({required String dns}) =>
      TaskEither.tryCatch(
          () => logger.isAreadyExists(dns)
              ? throw Exception("Dns Already exists")
              : platforms.modifie(dns: dns),
          (e, __) => e is PlatformException
              ? Failures(failure: e)
              : Failures.unknow(e.toString())).map((_) => unit).chainFirst(
          (_) => logger.log(
              dnsModel: DnsModel(
                  isActive: true,
                  dsaAddress: dns,
                  timesTamps: DateTime.now().toDateTime())));

  @override
  TaskEither<Failures, bool> stopDns({required String dns}) {
    return TaskEither.tryCatch(
            () => isActive(dns)
                ? platforms.stop(dns: dns)
                : platforms.modifie(dns: dns),
            (e, __) => Failures.unknow(e.toString()))
        .chainFirst((_) => logger.toogle(dns).toTaskEither())
        .map((_) => true);
  }

  bool isActive(String dns) => logger
      .getLogs()
      .where((test) => test.dsaAddress == dns)
      .any((test) => test.isActive);
}

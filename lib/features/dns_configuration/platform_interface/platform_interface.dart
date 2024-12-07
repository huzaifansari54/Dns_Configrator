import 'package:dns_configurator/core/exception/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PlatformInterface {
  TaskEither<Failures, bool> stopDns({required String dns});
  TaskEither<Failures, Unit> modifiyDNS({required String dns});
}

import 'package:dns_configurator/core/exception/platform_exception.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Failures {
  final PlatformException failure;
  const Failures({required this.failure});
  factory Failures.unknow(String error) =>
      Failures(failure: UnknownPlatform(error));

  @override
  String toString() => failure.toString();
  @override
  int get hashCode => failure.hashCode;
  @override
  bool operator ==(covariant Failures other) {
    return other.failure == failure ? other.hashCode == hashCode : false;
  }
}

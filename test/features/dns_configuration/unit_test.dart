import 'package:dns_configurator/core/exception/failures.dart';
import 'package:dns_configurator/core/exception/platform_exception.dart';
import 'package:dns_configurator/features/dns_configuration/model/model.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platform_impl.dart';
import 'package:dns_configurator/features/logger/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'platform/mock_platform.dart';

// mock class

void main() {
  const dns = "8.8.8.8";
  late final UnspporetePlatform unspporetePlatform;
  late final MockAndroidPlatform mockAndroidPlatform;
  late final MockMacPlatform mockMacPlatform;
  late final MockLinuxPlatform mockLinuxPlatform;
  late final MockWindowsPlatform mockWindowsPlatform;
  late final PlatformImpl platformImpl;
  late final PlatformImpl androidplatformImpl;
  late final PlatformImpl macplatformImpl;
  late final PlatformImpl windowsplatformImpl;
  late final PlatformImpl linuxlatformImpl;
  late final SharedPreferences mockSharedPreferences;
  late final ILogger logger;
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    mockSharedPreferences = await SharedPreferences.getInstance();
    logger = MockLogger();
    unspporetePlatform = UnspporetePlatform();
    mockAndroidPlatform = MockAndroidPlatform();
    mockWindowsPlatform = MockWindowsPlatform();
    mockLinuxPlatform = MockLinuxPlatform();
    mockMacPlatform = MockMacPlatform();
    windowsplatformImpl =
        PlatformImpl.fromPlatForm(mockWindowsPlatform, logger);
    macplatformImpl = PlatformImpl.fromPlatForm(mockMacPlatform, logger);
    linuxlatformImpl = PlatformImpl.fromPlatForm(mockLinuxPlatform, logger);
    platformImpl = PlatformImpl.fromPlatForm(unspporetePlatform, logger);
    androidplatformImpl =
        PlatformImpl.fromPlatForm(mockAndroidPlatform, logger);
  });
  group(' Unknow Platform specific tests', () {
    test('Unsupport platform test', () async {
      final resultOrFailure = await platformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<UnknownPlatform>());
    });
  });
  group('Android Platform specific tests', () {
    test('Android platform failure  test', () async {
      mockAndroidPlatform.setError = true;
      final resultOrFailure =
          await androidplatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<AndroidException>());

      mockAndroidPlatform.setError = false;
    });
    test('Android platform unknowfailure  test', () async {
      mockAndroidPlatform.setUnknowError = true;
      final resultOrFailure =
          await androidplatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<UnknownPlatform>());
      mockAndroidPlatform.setUnknowError = false;
    });
    test('Android success platform test', () async {
      mockAndroidPlatform.setError = false;
      mockAndroidPlatform.setUnknowError = false;

      final resultOrFailure =
          await androidplatformImpl.modifiyDNS(dns: dns).run();
      final success = resultOrFailure.getOrElse((_) => unit);
      expect(resultOrFailure, isA<Right<Failures, Unit>>());
      expect(success, isA<Unit>());
    });
  });
  group('MacPlatform specific tests', () {
    test('Mac platform failure  test', () async {
      mockMacPlatform.setError = true;
      final resultOrFailure = await macplatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<MacException>());
      mockMacPlatform.setError = false;
    });
    test('Mac platform unknowfailure  test', () async {
      mockMacPlatform.setUnknowError = true;
      final resultOrFailure = await macplatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<UnknownPlatform>());
      mockMacPlatform.setUnknowError = false;
    });
    test('Mac success platform test', () async {
      mockMacPlatform.setError = false;
      mockMacPlatform.setUnknowError = false;

      final resultOrFailure = await macplatformImpl.modifiyDNS(dns: dns).run();
      final success = resultOrFailure.getOrElse((_) => unit);
      expect(resultOrFailure, isA<Right<Failures, Unit>>());
      expect(success, isA<Unit>());
    });
  });
  group('WindowsPlatform specific tests', () {
    test('Windows platform failure test', () async {
      mockWindowsPlatform.setError = true;
      final resultOrFailure =
          await windowsplatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<WindowException>());
      mockWindowsPlatform.setError = false;
    });
    test('Windows platform unknowfailure  test', () async {
      mockWindowsPlatform.setUnknowError = true;
      final resultOrFailure =
          await windowsplatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<UnknownPlatform>());
      mockWindowsPlatform.setUnknowError = false;
    });
    test('Windows success platform test', () async {
      mockWindowsPlatform.setError = false;
      mockWindowsPlatform.setUnknowError = false;

      final resultOrFailure =
          await windowsplatformImpl.modifiyDNS(dns: dns).run();
      final success = resultOrFailure.getOrElse((_) => unit);
      expect(resultOrFailure, isA<Right<Failures, Unit>>());
      expect(success, isA<Unit>());
    });
  });
  group('LinuxPlatform specific tests', () {
    test('Linux platform failure  test', () async {
      mockLinuxPlatform.setError = true;
      final resultOrFailure = await linuxlatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<LinuxException>());
      mockLinuxPlatform.setError = false;
    });
    test('Linux platform unknowfailure  test', () async {
      mockLinuxPlatform.setUnknowError = true;
      final resultOrFailure = await linuxlatformImpl.modifiyDNS(dns: dns).run();
      final failres = resultOrFailure
          .getLeft()
          .getOrElse(() => Failures.unknow("UnknowError"));
      expect(resultOrFailure, isA<Left<Failures, Unit>>());
      expect(failres.failure, isA<UnknownPlatform>());
      mockLinuxPlatform.setUnknowError = false;
    });
    test('Linux success platform test', () async {
      mockLinuxPlatform.setError = false;
      mockLinuxPlatform.setUnknowError = false;

      final resultOrFailure = await linuxlatformImpl.modifiyDNS(dns: dns).run();
      final success = resultOrFailure.getOrElse((_) => unit);
      expect(resultOrFailure, isA<Right<Failures, Unit>>());
      expect(success, isA<Unit>());
    });
  });
}

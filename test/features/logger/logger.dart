import 'package:dns_configurator/features/dns_configuration/model/model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dns_configurator/features/logger/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockShredPrefrenss extends Mock implements SharedPreferences {
  static const KEY = "KEY";
}

void main() {
  late final Logger logger;
  late final MockShredPrefrenss mockShredPrefrenss;
  group("Logger", () {
    setUpAll(() {
      mockShredPrefrenss = MockShredPrefrenss();
      logger = Logger(db: mockShredPrefrenss);
    });

    test("get logs List is empty", () {
      when(
        () => mockShredPrefrenss.getStringList(MockShredPrefrenss.KEY),
      ).thenAnswer((_) => []);
      final logs = logger.getLogs();
      expect(true, logs.isEmpty);
    });
    test("get logs List is empty", () async {
      when(
        () => mockShredPrefrenss.getStringList(MockShredPrefrenss.KEY),
      ).thenAnswer((_) => []);
      final logs =
          await logger.log(dnsModel: DnsModel.forTest("8.8.8.7")).run();
      expect(logs, isA<Right>());
    });
  });
}

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dns_configurator/features/connectivity/network_conectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivty extends Mock implements Connectivity {}

void main() {
  late final MockConnectivty connectivity;
  late final NetworkConectivity networkConectivity;
  final List<ConnectivityResult> none = [ConnectivityResult.none];
  final List<ConnectivityResult> other = [ConnectivityResult.other];
  final List<ConnectivityResult> wifi = [ConnectivityResult.wifi];
  final List<ConnectivityResult> mobile = [ConnectivityResult.mobile];
  final List<ConnectivityResult> bluethooth = [ConnectivityResult.bluetooth];
  final List<ConnectivityResult> vpn = [ConnectivityResult.vpn];
  final List<ConnectivityResult> ethernet = [ConnectivityResult.ethernet];
  final allConnection =
      other + none + wifi + mobile + bluethooth + vpn + ethernet;
  final allWithoutwifi_mobile = other + none + bluethooth + vpn + ethernet;

  setUpAll(() {
    connectivity = MockConnectivty();
    networkConectivity = NetworkConectivity(connectivity: connectivity);
  });
  group("Connectivity", () {
    test("result when none", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => none);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });
    test("result when other", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => other);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });
    test("result when wifi", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => wifi);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, true);
    });
    test("result when mobile", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => mobile);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, true);
    });
    test("result when vpn", () async {
      when(() => connectivity.checkConnectivity()).thenAnswer((_) async => vpn);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });
    test("result when bluthooth", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => bluethooth);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });
    test("result when ethernet", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => ethernet);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });
    test("result when mobile and wifi", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => [...mobile, ...wifi]);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, true);
    });
    test("result when without mobile and wifi", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => allWithoutwifi_mobile);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });

    test("result when  all", () async {
      when(() => connectivity.checkConnectivity())
          .thenAnswer((_) async => allConnection);
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, true);
    });
    test("result when throw", () async {
      when(() => connectivity.checkConnectivity()).thenThrow(Exception());
      final isConnected = await networkConectivity.isConnected();
      expect(isConnected, false);
    });
  });
}

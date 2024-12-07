import 'package:dns_configurator/core/constants/constants.dart';
import 'package:dns_configurator/features/dns_configuration/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'state.freezed.dart';

@freezed
abstract class State with _$State {
  const State._();
  const factory State(
      {required String dnsAdress,
      required List<DnsModel> logs,
      required bool loading,
      required String error,
      required bool isNetwork}) = _State;

  factory State.init() => const State(
      logs: [], dnsAdress: "", loading: false, error: "", isNetwork: false);

  bool validDns() => Constant.ipRgx.hasMatch(dnsAdress);
}

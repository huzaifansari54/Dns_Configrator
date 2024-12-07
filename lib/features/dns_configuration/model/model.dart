import 'dart:convert';

import 'package:dns_configurator/core/extensions/types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';

@freezed
abstract class DnsModel with _$DnsModel {
  const DnsModel._();
  const factory DnsModel(
      {required String dsaAddress,
      required String timesTamps,
      required bool isActive}) = _DnsModel;

  String toJson() => json.encode({
        "dsaAddress": dsaAddress,
        "timesTamps": timesTamps,
        "isActive": isActive
      });

  factory DnsModel.fromMap(Map<String, dynamic> json) => DnsModel(
      dsaAddress: json["dsaAddress"],
      timesTamps: json["timesTamps"],
      isActive: json["isActive"] ?? false);
}

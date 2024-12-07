import 'dart:convert';
import 'package:dns_configurator/core/exception/failures.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dns_configuration/model/model.dart';

abstract interface class ILogger {
  TaskEither<Failures, Unit> log({required DnsModel dnsModel});
  List<DnsModel> getLogs();
  IOEither<Failures, Unit> toogle(String dns);
  bool isAreadyExists(String dns);
}

class Logger implements ILogger {
  final SharedPreferences _db;
  static const KEY = "DB_KEY";

  const Logger({required SharedPreferences db}) : _db = db;
  TaskEither<Failures, Unit> log({required DnsModel dnsModel}) {
    final logs = _db.getStringList(Logger.KEY) ?? [];
    logs.add(dnsModel.toJson());
    return TaskEither.tryCatch(
        () async => await _db.setStringList(Logger.KEY, logs),
        (e, _) => Failures.unknow("failure from Logger")).map((e) => unit);
  }

  @override
  List<DnsModel> getLogs() => (_db.getStringList(Logger.KEY) ?? [])
      .map((e) => json.decode(e))
      .map((json) => DnsModel.fromMap(json))
      .toList();

  @override
  IOEither<Failures, Unit> toogle(String dns) {
    return IOEither.tryCatch(
            () => _toogle(dns), (e, _) => Failures.unknow("error from "))
        .map((e) => unit);
  }

  void _toogle(String dns) {
    final logs = getLogs();
    var log = logs.firstWhere((test) => test.dsaAddress == dns);
    final index = logs.indexWhere((test) => test.dsaAddress == dns);
    log = log.copyWith(isActive: !log.isActive);
    logs.removeAt(index);
    logs.insert(index, log);
    _db.setStringList(Logger.KEY, logs.map((e) => e.toJson()).toList());
  }

  @override
  bool isAreadyExists(String dns) =>
      getLogs().any((test) => test.dsaAddress == dns);
}

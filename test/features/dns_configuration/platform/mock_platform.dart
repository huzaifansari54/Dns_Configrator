import 'package:dns_configurator/core/exception/failures.dart';
import 'package:dns_configurator/core/exception/platform_exception.dart';
import 'package:dns_configurator/features/dns_configuration/model/model.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platforms.dart';
import 'package:dns_configurator/features/logger/logger.dart';
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/io_either.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:fpdart/src/unit.dart';

class UnspporetePlatform extends Platforms {
  @override
  modifie({required String dns}) => throw UnimplementedError();
}

class MockAndroidPlatform extends Platforms {
  bool _specificError = false;
  bool _unknowError = false;
  set setError(bool val) => _specificError = val;
  set setUnknowError(bool val) => _unknowError = val;

  @override
  Future<void> modifie({required String dns}) {
    try {
      if (_specificError) throw AndroidException();
      if (_unknowError) throw UnimplementedError();
      return Future.value();
    } on AndroidException catch (_) {
      throw AndroidException();
    } catch (exp) {
      throw Exception("Unknow Error $exp");
    }
  }
}

class MockMacPlatform extends Platforms {
  bool _specificError = false;
  bool _unknowError = false;
  set setError(bool val) => _specificError = val;
  set setUnknowError(bool val) => _unknowError = val;

  @override
  Future<void> modifie({required String dns}) {
    try {
      if (_specificError) throw MacException();
      if (_unknowError) throw UnimplementedError();
      return Future.value();
    } on MacException catch (_) {
      throw MacException();
    } catch (exp) {
      throw Exception("Unknow Error $exp");
    }
  }
}

class MockWindowsPlatform extends Platforms {
  bool _specificError = false;
  bool _unknowError = false;
  set setError(bool val) => _specificError = val;
  set setUnknowError(bool val) => _unknowError = val;
  @override
  Future<void> modifie({required String dns}) {
    try {
      if (_specificError) throw WindowException();
      if (_unknowError) throw UnimplementedError();
      return Future.value();
    } on WindowException catch (_) {
      throw WindowException();
    } catch (exp) {
      throw Exception("Unknow Error $exp");
    }
  }
}

class MockLinuxPlatform extends Platforms {
  bool _specificError = false;
  bool _unknowError = false;
  set setError(bool val) => _specificError = val;
  set setUnknowError(bool val) => _unknowError = val;

  @override
  Future<void> modifie({required String dns}) {
    try {
      if (_specificError) throw LinuxException();
      if (_unknowError) throw UnimplementedError();
      return Future.value();
    } on LinuxException catch (_) {
      throw LinuxException();
    } catch (exp) {
      throw Exception("Unknow Error $exp");
    }
  }
}

class MockLogger implements ILogger {
  bool _isEmpty = false;
  bool _logFailure = false;
  bool _isAlreadyExist = false;
  set setEmpty(bool val) => _isEmpty = val;
  set setLogFailure(bool val) => _logFailure = val;
  set setAlready(bool val) => _isAlreadyExist = val;

  @override
  List<DnsModel> getLogs() => _isEmpty ? [] : [DnsModel.forTest("8.8.8.8")];

  @override
  bool isAreadyExists(String dns) => _isAlreadyExist;

  @override
  TaskEither<Failures, Unit> log({required DnsModel dnsModel}) {
    if (_logFailure) return TaskEither.left(Failures.unknow("error"));
    return TaskEither.right(unit);
  }

  @override
  IOEither<Failures, Unit> toogle(String dns) {
    // TODO: implement toogle
    throw UnimplementedError();
  }
}

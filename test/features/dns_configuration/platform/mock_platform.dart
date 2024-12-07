import 'package:dns_configurator/core/exception/platform_exception.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platforms.dart';

class UnspporetePlatform extends Platforms {
  @override
  modifie() => throw UnimplementedError();
}

class MockAndroidPlatform extends Platforms {
  bool _specificError = false;
  bool _unknowError = false;
  set setError(bool val) => _specificError = val;
  set setUnknowError(bool val) => _unknowError = val;

  @override
  Future<void> modifie() {
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
  Future<void> modifie() {
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
  Future<void> modifie() {
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
  Future<void> modifie() {
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

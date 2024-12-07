class PlatformException implements Exception {
  const PlatformException();

  @override
  bool operator ==(Object other) {
    return super.hashCode == other.hashCode;
  }

  @override
  int get hashCode => super.hashCode;
}

class AndroidException implements PlatformException {}

class LinuxException implements PlatformException {}

class WindowException implements PlatformException {}

class MacException implements PlatformException {}

class UnknownPlatform implements PlatformException {
  final String error;
  const UnknownPlatform(this.error);
  @override
  String toString() => error;
}

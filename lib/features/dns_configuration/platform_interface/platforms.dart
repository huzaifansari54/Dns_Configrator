abstract class Platforms {
  Future<void> modifie({required String dns});

  // implemented only for android
  Future<void> stop({required String dns}) => throw UnimplementedError();
}

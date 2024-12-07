import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dns_configurator/features/connectivity/network_conectivity.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/android_platform.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/linux_platform.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/mac_platform.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platform_impl.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/platform_interface.dart';
import 'package:dns_configurator/features/dns_configuration/platform_interface/window_platform.dart';
import 'package:dns_configurator/features/logger/logger.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lc = GetIt.instance;

setUp() async {
  lc.registerLazySingleton(() => Connectivity());
  lc.registerLazySingletonAsync(() async => SharedPreferences.getInstance());
  await lc.isReady<SharedPreferences>();
  lc.registerLazySingleton<ILogger>(() => Logger(db: lc()));
  lc
    ..registerLazySingleton(() => AndroidPlatform())
    ..registerLazySingleton(() => LinuxPlatform())
    ..registerLazySingleton(() => WindowPlatform())
    ..registerLazySingleton(() => MacPlatform());
  lc.registerLazySingleton<PlatformInterface>(() => PlatformImpl(lc()));
  lc.registerLazySingleton<$NetworkConectivity>(
      () => NetworkConectivity(connectivity: lc()));
}

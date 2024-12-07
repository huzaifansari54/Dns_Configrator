import 'package:dns_configurator/core/extensions/types.dart';
import 'package:dns_configurator/core/theme/theme.dart';
import 'package:dns_configurator/features/dns_configuration/view/pages/dns_configurator_page.dart';
import 'package:dns_configurator/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => ref.setTheme(context));
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      home: DnsConfiguratorPage(),
    );
  }
}

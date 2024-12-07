import 'dart:ui';
import 'package:dns_configurator/core/extensions/types.dart';
import 'package:dns_configurator/core/theme/theme_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider =
    StateNotifierProvider<ThemeBloc, ThemeState>((_) => ThemeBloc());

class ThemeBloc extends StateNotifier<ThemeState> {
  ThemeBloc() : super(ThemeState.light());

  setTheme(BuildContext context) => switch (context.getTheme()) {
        Brightness.dark => state = state.copyWith(isDark: true),
        Brightness.light => state = state.copyWith(isDark: false)
      };
}

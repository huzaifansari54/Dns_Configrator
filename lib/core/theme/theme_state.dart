import 'package:freezed_annotation/freezed_annotation.dart';
part 'theme_state.freezed.dart';

@freezed
abstract class ThemeState with _$ThemeState {
  const ThemeState._();
  const factory ThemeState({required bool isDark}) = _ThemeState;
  factory ThemeState.light() => const ThemeState(isDark: false);
}

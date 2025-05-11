part of 'app_theme_cubit.dart';

@immutable
sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}

final class AppThemeData extends AppThemeState {
  final ThemeMode themeMode;

  AppThemeData({required this.themeMode});
}

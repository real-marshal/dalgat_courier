import 'package:dalgat_courier/common/default_settings.dart' as defaultSettings;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppSettingsBloc {
  static final ThemeData _theme = ThemeData(
      primarySwatch: defaultSettings.primartSwatch,
      accentColor: defaultSettings.accentColor);
  final BehaviorSubject<ThemeData> _themeBS = BehaviorSubject.seeded(_theme);

  /// Primary swatch of the app
  final BehaviorSubject<MaterialColor> _primarySwatchBS = BehaviorSubject();

  Stream<ThemeData> get themeData => _themeBS.stream;
  Stream<MaterialColor> get primarySwatch => _primarySwatchBS.stream;

  AppSettingsBloc() {
    _primarySwatchBS.listen((value) => _themeBS.add(ThemeData(
        primarySwatch: value, accentColor: defaultSettings.accentColor)));
  }

  void setPrimarySwatch(MaterialColor primarySwatch) =>
      _primarySwatchBS.add(primarySwatch);

  void dispose() {
    _themeBS.close();
    _primarySwatchBS.close();
  }
}

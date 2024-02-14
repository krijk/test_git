import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';

const AppBrightness initialAppBrightness = AppBrightness.system;
const Color initialColor = Colors.grey;

const bool initialAnimateExpressions = true;
const double initialIndent = 40.0;
const IndentType initialIndentType = IndentType.connectingLines;
const double initialLineOrigin = 0.5;
const double initialLineThickness = 2.0;
const bool initialRoundedCorners = false;
const bool initialFilterCapital = false;

/// Preference key
enum PrefKey {
  // common
  brightness,
  color,

  // tree
  animateExpansions,
  indent,
  indentType,
  lineOrigin,
  lineThickness,
  roundedCorners,
  filterCapital,
  ;

  String get key => toString();

  Future<dynamic> get preference async {
    switch (this) {
      case PrefKey.brightness:
        return AppBrightness.getEnumByName(await Pref.getString(key)) ?? initialAppBrightness;
      case PrefKey.color:
        return Color(await Pref.getInt(key, initialColor.value));
      case PrefKey.animateExpansions:
        return Pref.getBool(
          key,
          defaultVal: initialAnimateExpressions,
        );
      case PrefKey.indent:
        return Pref.getDouble(key, initialIndent);
      case PrefKey.indentType:
        return IndentType.getEnumByName(await Pref.getString(key)) ?? initialIndentType;
      case PrefKey.lineOrigin:
        return Pref.getDouble(key, initialLineOrigin);
      case PrefKey.lineThickness:
        return Pref.getDouble(key, initialLineThickness);
      case PrefKey.roundedCorners:
        return Pref.getBool(
          key,
          defaultVal: initialRoundedCorners,
        );
      case PrefKey.filterCapital:
        return Pref.getBool(
          key,
          defaultVal: initialFilterCapital,
        );
    }
  }

  set preference(dynamic value) {
    switch (this) {
      case PrefKey.brightness:
        Pref.setString(key, (value as AppBrightness).name);
        break;
      case PrefKey.animateExpansions:
        Pref.setBool(key, value: value);
        break;
      case PrefKey.color:
        Pref.setInt(key, (value as Color).value);
        break;
      case PrefKey.indent:
        Pref.setDouble(key, value);
        break;
      case PrefKey.indentType:
        Pref.setString(key, (value as IndentType).name);
        break;
      case PrefKey.lineOrigin:
        Pref.setDouble(key, value);
        break;
      case PrefKey.lineThickness:
        Pref.setDouble(key, value);
        break;
      case PrefKey.roundedCorners:
        Pref.setBool(key, value: value);
        break;
      case PrefKey.filterCapital:
        Pref.setBool(key, value: value);
        break;
      default:
        break;
    }
  }
}

extension BrightnessEx on Brightness {
  /// Get enum name using extension
  String get name {
    return toString().split('.').last;
  }

  /// Get enum by its name
  static Brightness? getEnumByName(String name) {
    for (final Brightness e in Brightness.values) {
      if (e.name == name) {
        return e;
      }
    }
    return null;
  }
}

enum IndentType {
  connectingLines('Connecting Lines'),
  scopingLines('Scoping Lines'),
  blank('Blank');

  final String title;

  const IndentType(this.title);

  static Iterable<IndentType> allExcept(IndentType type) {
    return values.where((IndentType element) => element != type);
  }

  String get name {
    return toString().split('.').last;
  }

  static IndentType? getEnumByName(String name) {
    for (final IndentType e in IndentType.values) {
      if (e.name == name) {
        return e;
      }
    }
    return null;
  }
}

enum AppBrightness {
  system,
  light,
  dark,
  ;

  Widget get icon {
    return switch (this) {
      AppBrightness.system => const Icon(Icons.color_lens),
      AppBrightness.light => const Icon(Icons.light),
      AppBrightness.dark => const Icon(Icons.dark_mode),
    };
  }

  Brightness getBrightness(BuildContext context) {
    Brightness brightness;
    switch (this) {
      case AppBrightness.light:
        brightness = Brightness.light;
        break;
      case AppBrightness.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = MediaQuery.of(context).platformBrightness;
        break;
    }
    return brightness;
  }

  /// Get enum by its name
  static AppBrightness? getEnumByName(String name) {
    for (final AppBrightness e in AppBrightness.values) {
      if (e.name == name) {
        return e;
      }
    }
    return null;
  }
}

class SettingsState {
  SettingsState({
    this.appBrightness = initialAppBrightness,
    this.color = initialColor,
    this.animateExpansions = initialAnimateExpressions,
    this.indent = initialIndent,
    this.indentType = initialIndentType,
    this.lineOrigin = initialLineOrigin,
    this.lineThickness = initialLineThickness,
    this.roundedCorners = initialRoundedCorners,
    this.filterCapital = false,
  });

  final AppBrightness appBrightness;
  final Color color;
  final bool animateExpansions;
  final double indent;
  final IndentType indentType;
  final double lineOrigin;
  final double lineThickness;
  final bool roundedCorners;
  final bool filterCapital;

  SettingsState copyWith({
    AppBrightness? appBrightness,
    Color? color,
    bool? animateExpansions,
    double? indent,
    IndentType? indentType,
    double? lineOrigin,
    double? lineThickness,
    bool? roundedCorners,
    bool? filterCapital,
  }) {
    return SettingsState(
      appBrightness: appBrightness ?? this.appBrightness,
      color: color ?? this.color,
      animateExpansions: animateExpansions ?? this.animateExpansions,
      indent: indent ?? this.indent,
      indentType: indentType ?? this.indentType,
      lineOrigin: lineOrigin ?? this.lineOrigin,
      lineThickness: lineThickness ?? this.lineThickness,
      roundedCorners: roundedCorners ?? this.roundedCorners,
      filterCapital: filterCapital ?? this.filterCapital,
    );
  }
}

class SettingsController with ChangeNotifier {
  SettingsController() {
    _state = SettingsState();
  }

  SettingsState get state => _state;
  late SettingsState _state;

  @protected
  set state(SettingsState state) {
    _state = state;
    notifyListeners();
  }

  /// Retrieve preference settings
  Future<void> retrievePreference() async {
    final AppBrightness appBrightness = await PrefKey.brightness.preference;
    final Color color = await PrefKey.color.preference;
    final bool animateExpansions = await PrefKey.animateExpansions.preference;
    final double indent = await PrefKey.indent.preference;
    final IndentType indentType = await PrefKey.indentType.preference;
    final double lineOrigin = await PrefKey.lineOrigin.preference;
    final double lineThickness = await PrefKey.lineThickness.preference;
    final bool roundedCorners = await PrefKey.roundedCorners.preference;
    final bool filterCapital = await PrefKey.filterCapital.preference;

    final SettingsState state = SettingsState();
    _state = state.copyWith(
      appBrightness: appBrightness,
      color: color,
      animateExpansions: animateExpansions,
      indent: indent,
      indentType: indentType,
      lineOrigin: lineOrigin,
      lineThickness: lineThickness,
      roundedCorners: roundedCorners,
      filterCapital: filterCapital,
    );
  }

  Future<void> storePreference() async {
    PrefKey.brightness.preference = state.appBrightness;
    PrefKey.color.preference = state.color;
    PrefKey.animateExpansions.preference = state.animateExpansions;
    PrefKey.indent.preference = state.indent;
    PrefKey.indentType.preference = state.indentType;
    PrefKey.lineOrigin.preference = state.lineOrigin;
    PrefKey.lineThickness.preference = state.lineThickness;
    PrefKey.roundedCorners.preference = state.roundedCorners;
    PrefKey.filterCapital.preference = state.filterCapital;
  }

  void restoreAll() {
    restoreSearch();
    restoreThemeCommon();
    restoreThemeTree();
  }

  void restoreSearch() {
    state = state.copyWith(
      filterCapital: initialFilterCapital,
    );
    PrefKey.filterCapital.preference = state.filterCapital;
  }

  void restoreTheme() {
    debugPrint('DebugSA restoreTheme()');
    restoreThemeCommon();
    restoreThemeTree();
  }

  void restoreThemeCommon() {
    debugPrint('DebugSA restoreThemeCommon()');
    PrefKey.brightness.preference = initialAppBrightness;
    state = state.copyWith(
      color: initialColor,
    );
  }

  void restoreThemeTree() {
    debugPrint('DebugSA restoreThemeTree()');
    state = state.copyWith(
      animateExpansions: initialAnimateExpressions,
      indent: initialIndent,
      indentType: initialIndentType,
      lineOrigin: initialLineOrigin,
      lineThickness: initialLineThickness,
      roundedCorners: initialRoundedCorners,
    );

    PrefKey.animateExpansions.preference = state.animateExpansions;
    PrefKey.indent.preference = state.indent;
    PrefKey.indentType.preference = state.indentType;
    PrefKey.lineOrigin.preference = state.lineOrigin;
    PrefKey.lineThickness.preference = state.lineThickness;
    PrefKey.roundedCorners.preference = state.roundedCorners;
  }

  void restoreGeneral() {}

  void updateAppBrightness(AppBrightness value) {
    if (state.appBrightness == value) return;
    state = state.copyWith(appBrightness: value);
    PrefKey.brightness.preference = value;
  }

  void updateColor(Color value) {
    if (state.color == value) return;
    state = state.copyWith(color: value);
    PrefKey.color.preference = value;
  }

  void updateAnimateExpansions({bool value = false}) {
    if (value == state.animateExpansions) return;
    state = state.copyWith(animateExpansions: value);
    PrefKey.animateExpansions.preference = value;
  }

  void updateIndent(double value) {
    if (state.indent == value) return;
    state = state.copyWith(indent: value);
    PrefKey.indent.preference = value;
  }

  void updateIndentType(IndentType value) {
    if (state.indentType == value) return;
    state = state.copyWith(indentType: value);
    PrefKey.indentType.preference = value;
  }

  void updateLineOrigin(double value) {
    if (state.lineOrigin == value) return;
    state = state.copyWith(lineOrigin: value);
    PrefKey.lineOrigin.preference = value;
  }

  void updateLineThickness(double value) {
    if (state.lineThickness == value) return;
    state = state.copyWith(lineThickness: value);
    PrefKey.lineThickness.preference = value;
  }

  void updateRoundedCorners({bool value = false}) {
    if (state.roundedCorners == value) return;
    state = state.copyWith(roundedCorners: value);
    PrefKey.roundedCorners.preference = value;
  }

  void updateFilterCapital({bool value = false}) {
    if (value == state.filterCapital) return;
    state = state.copyWith(filterCapital: value);
    PrefKey.filterCapital.preference = value;
  }
}

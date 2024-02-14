import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileTheme extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: const Text('Themes'),
      leading: const Icon(Icons.color_lens),
      description: const Text('Application, Brightness,  Accent color, Tree'),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingTheme(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}

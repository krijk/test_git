import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileAbout extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: const Text('About'),
      leading: const Icon(Icons.phone_android),
      description: const Text('Information about the app'),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingAbout(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}

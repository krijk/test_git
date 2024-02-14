import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileUpdateInfo extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: const Text('Update Information'),
      leading: const Icon(Icons.update),
      description: const Text('Change history'),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingUpdateInfo(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}

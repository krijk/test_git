import 'package:flutter/cupertino.dart';
import 'package:settings_ui/settings_ui.dart';

import '/src/navigation.dart';
import 'setting_contents.dart';

class SettingTileGeneral extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    return SettingsTile.navigation(
      title: const Text('Abstract settings screen'),
      leading: const Icon(CupertinoIcons.wrench),
      description: const Text("UI created to show plugin's possibilities"),
      onPressed: (BuildContext context) {
        Navigation.navigateTo(
          context: context,
          screen: const SettingsGeneral(),
          style: NavigationRouteStyle.material,
        );
      },
    );
  }
}

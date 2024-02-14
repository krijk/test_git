import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '/src/my_description.dart';

class ItemUpdateInfo extends AbstractSettingsTile {
  const ItemUpdateInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyDescriptionFile(path: 'assets/docs/update_info.md');
  }
}

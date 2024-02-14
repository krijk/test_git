import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controller.dart';

//* Filter Capital --------------------------------------------------

class SearchFilterCapital extends AbstractSettingsTile {
  const SearchFilterCapital({super.key});

  @override
  Widget build(BuildContext context) {
    final bool filterCapital = context.select<SettingsController, bool>(
      (SettingsController controller) => controller.state.filterCapital,
    );

    return SwitchListTile(
      title: const Text('Filter case sensitive'),
      value: filterCapital,
      onChanged: (bool value) {
        context.read<SettingsController>().updateFilterCapital(value: value);
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
    );
  }
}

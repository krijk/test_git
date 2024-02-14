import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controller.dart';

class AppBrightnessSelector extends AbstractSettingsTile {
  const AppBrightnessSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final AppBrightness selected = context.select<SettingsController, AppBrightness>(
      (SettingsController controller) => controller.state.appBrightness,
    );

    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    debugPrint('DebugSA appBrightness selected: $selected');
    PrefKey.brightness.preference = selected;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          selected.icon,
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 8),
              iconColor: colorScheme.onSurface,
              title: const Text('Brightness'),
              subtitle: Text(
                selected.name,
                style: TextStyle(color: colorScheme.primary),
              ),
              trailing: AppBrightnessCatalog2(
                selected: selected,
                // onSelected: onSelected,
                onSelected: (AppBrightness? selected) => onSelected2(context, selected),
              ),
              onTap: AppBrightnessCatalog2.showPopup,
            ),
          ),
        ],
      ),
    );
  }

  void onSelected(AppBrightness? value) {
    debugPrint('onSelected DebugSA $value');
    // context.read<SettingsController>().updateAppBrightness(value);
  }

  void onSelected2(BuildContext context, AppBrightness? value) {
    debugPrint('onSelected2 DebugSA $value');
    context.read<SettingsController>().updateAppBrightness(value!);
  }
}

class AppBrightnessCatalog2 extends StatelessWidget {
  const AppBrightnessCatalog2({
    super.key,
    required this.onSelected,
    required this.selected,
  });

  final ValueChanged<AppBrightness?> onSelected;
  final AppBrightness selected;

  static final GlobalKey<PopupMenuButtonState<AppBrightness>> popupMenuKey = GlobalKey();
  static void showPopup() => popupMenuKey.currentState?.showButtonMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppBrightness>(
      key: popupMenuKey,
      initialValue: selected,
      onSelected: onSelected,
      itemBuilder: (_) => <PopupMenuEntry<AppBrightness>>[
        for (final AppBrightness en in AppBrightness.values)
          PopupMenuItem<AppBrightness>(
            value: en,
            enabled: en != selected,
            child: Row(
              children: <Widget>[
                en.icon,
                const SizedBox(width: 16),
                Text(en.name),
              ],
            ),
          ),
      ],
      tooltip: 'Application brightness',
      icon: const Icon(Icons.more_vert),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/page_settings.dart';
import '/settings/controller.dart';
import '/src/navigation.dart';
import 'items/app_brightness.dart';
import 'items/contents_selector.dart';
import 'items/search_filter_capital.dart';

class SettingsCategories extends StatelessWidget {
  final bool shouldPop;
  const SettingsCategories({super.key, this.shouldPop = false});

  @override
  Widget build(BuildContext context) {
    final List<Widget> categories = <Widget>[
      const ContentsSelector(),
      // const AppBrightnessSelector(),
      const AppBrightnessSelector(),
      const SearchFilterCapital(),
    ];

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.separated(
            itemCount: categories.length,
            itemBuilder: (_, int index) => categories[index],
            separatorBuilder: (_, __) => const Divider(height: 1),
          ),
        ),
        ButtonSettingScreen(
          shouldPop: shouldPop,
        ),
      ],
    );
  }
}

//* Restore All Settings -------------------------------------------------------

class RestoreAllSettings extends StatelessWidget {
  const RestoreAllSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore'),
        onPressed: () => context.read<SettingsController>().restoreAll(),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

// Button to the Setting Screen
class ButtonSettingScreen extends StatelessWidget {
  final bool shouldPop;
  const ButtonSettingScreen({super.key, this.shouldPop = false});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.settings),
        label: const Text('Settings'),
        onPressed: () => navigate(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  void navigate(BuildContext context) {
    if (shouldPop) {
      Navigator.pop(context);
    }
    Navigation.navigateTo(
      context: context,
      screen: const PageSettings(),
      style: NavigationRouteStyle.material,
    );
  }
}

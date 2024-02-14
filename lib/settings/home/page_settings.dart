import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../drawer/items/search_filter_capital.dart';
import '/globals.dart';
import '/settings/controller.dart';
import 'about/setting_tile.dart';
import 'general/setting_tile.dart';
import 'theme/setting_tile.dart';
import 'update_info/setting_tile.dart';

const String pageTitle = 'Settings';

enum kCategory {
  general,
  theme,
  app,
  ;

  String get label {
    return name.capitalize();
  }

  Icon? get icon {
    return null;
  }
}

class PageSettings extends StatefulWidget {
  const PageSettings({super.key});

  @override
  State<PageSettings> createState() => PageSettingsState();
}

class PageSettingsState extends State<PageSettings> {
  kCategory selected = kCategory.general;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(pageTitle)),
      body: (MediaQuery.of(context).size.width > gScreenLarge) ? layoutLarge(context) : layoutSmall(context),
    );
  }

  Widget layoutSmall(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SettingsList(
            sections: settingContents(context),
          ),
        ),
        const RestoreSettings(category: null),
      ],
    );
  }

  Widget layoutLarge(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: settingMenu(context),
        ),
        const VerticalDivider(width: 1),
        Flexible(
          flex: 5,
          child: settingContent1(context, selected),
        ),
      ],
    );
  }

  Widget settingMenu(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: menuContents(context),
          ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: RestoreSettings(
            category: selected,
          ),
        ),
      ],
    );
  }

  List<Widget> menuContents(BuildContext context) {
    final List<Widget> list = <Widget>[];
    for (final kCategory e in kCategory.values) {
      list.add(menuItem(context, e));
    }
    return list;
  }

  ListTile menuItem(BuildContext context, kCategory category) {
    final ListTile item = ListTile(
      leading: category.icon,
      title: Text(category.label),
      selected: selected == category,
      onTap: () {
        setState(() {
          selected = category;
        });
      },
    );
    return item;
  }

  List<AbstractSettingsSection> settingContents(BuildContext context) {
    final List<AbstractSettingsSection> list = <AbstractSettingsSection>[];
    for (final kCategory e in kCategory.values) {
      list.add(getSettingSection(context, e, withTitle: true));
    }
    return list;
  }

  Widget settingContent1(BuildContext context, kCategory category, {bool withTitle = false}) {
    return SettingsList(
      sections: <AbstractSettingsSection>[
        SettingsSection(
          title: withTitle ? Text(category.label) : null,
          tiles: getTiles(context, category),
        ),
      ],
    );
  }

  SettingsSection getSettingSection(
    BuildContext context,
    kCategory category, {
    bool withTitle = false,
  }) {
    return SettingsSection(
      title: withTitle ? Text(category.label) : null,
      tiles: getTiles(context, category),
    );
  }

  List<AbstractSettingsTile> getTiles(BuildContext context, kCategory category) {
    switch (category) {
      case kCategory.general:
        return <AbstractSettingsTile>[
          SettingTileGeneral(),
          const SearchFilterCapital(),
        ];
      case kCategory.theme:
        return <AbstractSettingsTile>[
          SettingTileTheme(),
        ];
      case kCategory.app:
        return <AbstractSettingsTile>[
          SettingTileUpdateInfo(),
          SettingTileAbout(),
        ];
    }
  }
}

class RestoreSettings extends AbstractSettingsTile {
  final kCategory? category;

  const RestoreSettings({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
        onPressed: () => openDialog(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  void openDialog(BuildContext context) {
    const double padding = 8;
    String label = '';
    switch (category) {
      case kCategory.general:
      case kCategory.theme:
      case kCategory.app:
        label = 'Restore ${category!.label} settings?';
        break;
      case null:
        label = 'Restore all settings?';
        break;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(padding),
          title: Text(label),
          // content: const SizedBox(
          //   width: double.maxFinite,
          //   child: Text('Restore all settings?'),
          // ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                final SettingsController settingsController = context.read<SettingsController>();
                switch (category) {
                  case kCategory.general:
                  case kCategory.app:
                    break;
                  case kCategory.theme:
                    settingsController.restoreTheme();
                    break;
                  case null:
                    settingsController.restoreAll();
                    break;
                }
                Navigator.pop(context, 'Yes');
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

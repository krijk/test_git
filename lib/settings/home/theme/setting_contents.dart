import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../controller.dart';
import '../../drawer/items/app_brightness.dart';
import '/globals.dart';
import 'items/color_selector.dart';
import 'items/tree_theme.dart';

const String pageTitle = 'Theme';

enum kCategory {
  common,
  tree,
  ;

  String get label {
    return name.capitalize();
  }

  Icon? get icon {
    return null;
  }

  static kCategory getEnum(String label) {
    for (final kCategory e in values) {
      if (e.name == label.toLowerCase()) {
        return e;
      }
    }
    return kCategory.common;
  }
}

class SettingTile extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SettingTheme extends StatefulWidget {
  const SettingTheme({super.key});
  @override
  State<SettingTheme> createState() => SettingThemeState();
}

class SettingThemeState extends State<SettingTheme> {
  kCategory selected = kCategory.common;

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
        const RestoreSettings(
          category: null,
        ),
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
    final IndentType indentType = context.select<SettingsController, IndentType>(
      (SettingsController controller) => controller.state.indentType,
    );
    switch (category) {
      case kCategory.common:
        return <AbstractSettingsTile>[
          const AppBrightnessSelector(),
          const ColorSelector(),
        ];
      case kCategory.tree:
        return <AbstractSettingsTile>[
          TreeAnimation(),
          const Indent(),
          const IndentGuideType(),
          if (indentType != IndentType.blank) ...<AbstractSettingsTile>[
            if (indentType == IndentType.connectingLines) ...<AbstractSettingsTile>[
              const RoundedConnections(),
            ],
            const LineThickness(),
            const LineOrigin(),
          ],
        ];
    }
  }
}

class RestoreSettings extends AbstractSettingsTile {
  final kCategory? category;

  const RestoreSettings({this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
        onPressed: () {
          final SettingsController settingsController = context.read<SettingsController>();
          switch (category) {
            case kCategory.common:
              settingsController.restoreThemeCommon();
              break;
            case kCategory.tree:
              settingsController.restoreThemeTree();
              break;
            case null:
              settingsController.restoreTheme();
              break;
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(40),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

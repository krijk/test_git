import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';
import 'package:settings_ui/settings_ui.dart';

import '/globals.dart';
import 'items/item_about.dart';

const String pageTitle = 'App';

enum kCategory {
  about,
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
    return kCategory.about;
  }
}

class SettingAbout extends StatefulWidget {
  const SettingAbout({super.key});
  @override
  State<SettingAbout> createState() => SettingAboutState();
}

class SettingAboutState extends State<SettingAbout> {
  kCategory selected = kCategory.about;

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
      case kCategory.about:
        return <AbstractSettingsTile>[const ItemAbout()];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../drawer/items/helpers.dart';
import '/settings/controller.dart';

class TreeAnimation extends AbstractSettingsTile {
  @override
  Widget build(BuildContext context) {
    final bool animatedExpansions = context.select<SettingsController, bool>(
      (SettingsController controller) => controller.state.animateExpansions,
    );

    return SettingsTile.switchTile(
      onToggle: (bool value) => updateTreeAnimation(context, value: value),
      initialValue: animatedExpansions,
      leading: const Icon(Icons.animation),
      title: const Text('Animate Expand & Collapse'),
    );
  }

  void updateTreeAnimation(BuildContext context, {required bool value}) {
    context.read<SettingsController>().updateAnimateExpansions(value: value);
  }
}

//* Indent ---------------------------------------------------------------------

class Indent extends AbstractSettingsTile {
  const Indent({super.key});

  @override
  Widget build(BuildContext context) {
    final double indent = context.select<SettingsController, double>(
      (SettingsController controller) => controller.state.indent,
    );

    /*
    The following assertion was thrown building SliderListTile(dirty):
    Value 0.0 is not between minimum 0.1 and maximum 64.0
    'package:flutter/src/material/slider.dart':
    Failed assertion: line 194 pos 15: 'value >= min && value <= max'
     */
    return SliderListTile(
      title: 'Indent per Level',
      value: indent,
      min: 0.0,
      max: 64.0,
      onChanged: (double value) => context.read<SettingsController>().updateIndent(value.roundToDouble()),
    );
  }
}

//* Indent Guide Type ----------------------------------------------------------

class IndentGuideType extends AbstractSettingsTile {
  const IndentGuideType({super.key});

  @override
  Widget build(BuildContext context) {
    final IndentType indentType = context.select<SettingsController, IndentType>(
      (SettingsController controller) => controller.state.indentType,
    );

    return ExpansionTile(
      title: const Text('Indent Guide Type'),
      subtitle: Text(
        indentType.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      shape: const RoundedRectangleBorder(/*side: BorderSide.none*/),
      children: <Widget>[
        for (final IndentType type in IndentType.allExcept(indentType))
          ListTile(
            title: Text(type.title),
            onTap: () {
              context.read<SettingsController>().updateIndentType(type);
            },
            dense: true,
          ),
      ],
    );
  }
}

//* Rounded Line Connections ---------------------------------------------------

class RoundedConnections extends AbstractSettingsTile {
  const RoundedConnections({super.key});

  @override
  Widget build(BuildContext context) {
    final bool roundedConnections = context.select<SettingsController, bool>(
      (SettingsController controller) => controller.state.roundedCorners,
    );

    return SwitchListTile(
      title: const Text('Rounded Line Connections'),
      value: roundedConnections,
      onChanged: (bool value) {
        context.read<SettingsController>().updateRoundedCorners(value: value);
      },
      contentPadding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
    );
  }
}

//* Line Thickness -------------------------------------------------------------

class LineThickness extends AbstractSettingsTile {
  const LineThickness({super.key});

  @override
  Widget build(BuildContext context) {
    final double thickness = context.select<SettingsController, double>(
      (SettingsController controller) => controller.state.lineThickness,
    );

    return SliderListTile(
      title: 'Line Thickness',
      value: thickness,
      // min: 0.0,
      max: 8.0,
      divisions: 16,
      onChanged: (double value) {
        context.read<SettingsController>().updateLineThickness(value);
      },
    );
  }
}

//* Line Origin ----------------------------------------------------------------

class LineOrigin extends AbstractSettingsTile {
  const LineOrigin({super.key});

  @override
  Widget build(BuildContext context) {
    final double origin = context.select<SettingsController, double>(
      (SettingsController controller) => controller.state.lineOrigin,
    );

    return SliderListTile(
      title: 'Line Origin',
      value: origin,
      // min: 0.0,
      // max: 1.0,
      divisions: 10,
      onChanged: (double value) {
        context.read<SettingsController>().updateLineOrigin(value);
      },
    );
  }
}

//* Restore Theme Settings -------------------------------------------------------

class RestoreThemeSettings extends AbstractSettingsTile {
  const RestoreThemeSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.restore),
        label: const Text('Restore Settings'),
        onPressed: () => context.read<SettingsController>().restoreTheme(),
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}

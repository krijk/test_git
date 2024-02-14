import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../controller.dart';

//* Theme Color ----------------------------------------------------------------

class ColorSelector extends AbstractSettingsTile {
  const ColorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final Color selectedColor = context.select<SettingsController, Color>(
          (SettingsController controller) => controller.state.color,
    );

    return ExpansionTile(
      leading: const Icon(Icons.colorize),
      title: const Text('Accent Color'),
      trailing: ColorOption(color: selectedColor, canTap: false),
      shape: const RoundedRectangleBorder(/*side: BorderSide.none*/),
      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
      childrenPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      children: <Widget>[
        GridView.extent(
          shrinkWrap: true,
          maxCrossAxisExtent: 24,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Color>[Colors.grey, Colors.black, Colors.white]
              .followedBy(Colors.primaries.reversed)
              .followedBy(Colors.accents)
              .map(ColorOption.fromColor)
              .toList(growable: false),
        ),
      ],
    );
  }
}

class ColorOption extends StatelessWidget {
  const ColorOption({
    super.key,
    required this.color,
    this.canTap = true,
  });

  factory ColorOption.fromColor(Color color) => ColorOption(color: color);

  final Color color;
  final bool canTap;

  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(4));

  @override
  Widget build(BuildContext context) {
    void updateColor() => context.read<SettingsController>().updateColor(color);

    return Material(
      color: color,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: canTap ? updateColor : null,
        child: const SizedBox.square(dimension: 24),
      ),
    );
  }
}

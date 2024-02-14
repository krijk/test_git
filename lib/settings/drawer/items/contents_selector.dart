import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/contents/selection.dart';

class ContentsSelector extends StatelessWidget {
  const ContentsSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectedNotifier notifier = context.watch<SelectedNotifier>();
    final Selection selected = notifier.value;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 8),
      iconColor: colorScheme.onSurface,
      title: const Text('Selected Example'),
      subtitle: Text(
        selected.title,
        style: TextStyle(color: colorScheme.primary),
      ),
      trailing: ExamplesCatalog(
        selectedExample: selected,
        onExampleSelected: notifier.select,
      ),
      onTap: ExamplesCatalog.showPopup,
    );
  }
}

class ExamplesCatalog extends StatelessWidget {
  const ExamplesCatalog({
    super.key,
    required this.onExampleSelected,
    required this.selectedExample,
  });

  final ValueChanged<Selection?> onExampleSelected;
  final Selection selectedExample;

  static final GlobalKey<PopupMenuButtonState<Selection>> popupMenuKey = GlobalKey();
  static void showPopup() => popupMenuKey.currentState?.showButtonMenu();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Selection>(
      key: popupMenuKey,
      initialValue: selectedExample,
      onSelected: onExampleSelected,
      itemBuilder: (_) => <PopupMenuEntry<Selection>>[
        for (final Selection example in Selection.values)
          PopupMenuItem<Selection>(
            value: example,
            enabled: example != selectedExample,
            child: Row(
              children: <Widget>[
                example.icon,
                const SizedBox(width: 16),
                Text(example.title),
              ],
            ),
          ),
      ],
      tooltip: 'Open Examples Popup',
      icon: const Icon(Icons.more_vert),
    );
  }
}

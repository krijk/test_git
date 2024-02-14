import 'package:flutter/material.dart';

import 'categories.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, this.isDrawer = false});

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    late final Widget child = Column(
      children: <Widget>[
        Header(showCloseButton: isDrawer),
        const Divider(height: 1),
        Expanded(
          child: SettingsCategories(
            shouldPop: isDrawer,
          ),
        ),
      ],
    );

    if (isDrawer) {
      return Drawer(
        backgroundColor: Theme.of(context).canvasColor.withOpacity(0.8),
        child: child,
      );
    }

    return Material(
      child: SizedBox(
        width: 304,
        child: ListTileTheme.merge(
          style: ListTileStyle.drawer,
          child: child,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, this.showCloseButton = false});

  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (showCloseButton)
              IconButton(
                tooltip: 'Close settings',
                icon: const Icon(Icons.close),
                onPressed: () => Scaffold.maybeOf(context)?.closeDrawer(),
              ),
          ],
        ),
      ),
    );
  }
}

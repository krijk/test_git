import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/settings/controller.dart' show SettingsController;
import 'contents/selection.dart' show SelectedNotifier;
import 'src/app.dart' show App;
import 'src/searcher.dart' show SearchNotifier;

Future<void> main() async {
  runApp(
    MultiProvider(
      providers: <ChangeNotifierProvider<ChangeNotifier>>[
        ChangeNotifierProvider<SettingsController>(create: (_) => SettingsController()),
        ChangeNotifierProvider<SelectedNotifier>(create: (_) => SelectedNotifier()),
        ChangeNotifierProvider<SearchNotifier>(create: (_) => SearchNotifier()),
      ],
      child: const App(),
    ),
  );
}

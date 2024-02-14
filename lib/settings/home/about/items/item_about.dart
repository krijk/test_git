import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';

class ItemAbout extends AbstractSettingsTile {
  const ItemAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getInfo(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: MarkdownBody(data: snapshot.data!),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<String> getInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String appName = packageInfo.appName;
    // final String packageName = packageInfo.packageName;
    final String version = packageInfo.version;
    final String buildNumber = packageInfo.buildNumber;
    return '### appName'
        '\n$appName'
        '\n### VersionName'
        '\n$version'
        '\n### VersionCode'
        '\n$buildNumber';
  }
}

import 'package:flutter/material.dart';

/// Base class for page
abstract class PageBase extends StatelessWidget {

  /// page title
  final String title;

  /// Base class for page
  const PageBase(this.title);

  /// test function
  String test(BuildContext context) {
    return '';
  }
}

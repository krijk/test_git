import 'package:flutter/material.dart';
import 'package:mylib01/lib.dart';
import '/src/page_stateless.dart';

const String _text01 = '''
Base page
''';

/// Folder home
class Base extends PageStateless {
  ///
  const Base() : super('Base');

  @override
  String test(BuildContext context) {
    return _test01();
  }

  String _test01() {
    final String method = Utl.getMethodName();
    return '$method'
        '\n$_text01';
  }
}

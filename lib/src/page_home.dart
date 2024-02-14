import 'package:flutter/material.dart';

import '/contents/pages.dart';
import '/src/card_view.dart';
import '/src/page_list.dart';
import 'my_description.dart';
import 'page_base.dart';
import 'page_info.dart';

/// Folder home with CardList
class PageHome extends PageInfo {
  ///
  final String description;

  ///
  PageHome(String id, String title, {this.description = ''}) : super(id, HomeContent(id, title, description));
}

/// Page
class HomeContent extends PageBase {
  ///
  final String id;

  ///
  final String description;

  ///
  const HomeContent(this.id, String title, this.description) : super(title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: (MediaQuery.of(context).size.width > 720) ? landscape() : portrait(),
    );
  }

  Widget portrait() {
    final PageList pageList = gPageGroup.getChildPages(id: id);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
            child: MyDescriptionString(description),
          ),
        ),
        Flexible(
          flex: 3,
          child: CardWidget(pageList),
        ),
      ],
    );
  }

  Widget landscape() {
    final PageList pageList = gPageGroup.getChildPages(id: id);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 8),
            child: MyDescriptionString(description),
          ),
        ),
        Flexible(
          flex: 3,
          child: CardWidget(pageList),
        ),
      ],
    );
  }

  @override
  String test(BuildContext context) {
    throw UnimplementedError();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MyDescriptionFile extends StatefulWidget {
  final String path;
  Future<String> get description => rootBundle.loadString(path);
  final EdgeInsetsGeometry padding;

  const MyDescriptionFile({required this.path, this.padding = const EdgeInsets.all(10)});

  @override
  State<MyDescriptionFile> createState() => MyDescriptionFileState();
}

class MyDescriptionFileState extends State<MyDescriptionFile> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: widget.description,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: widget.padding,
            child: Scrollbar(
              child: SingleChildScrollView(
                controller: scrollController,
                child: MarkdownBody(
                  data: snapshot.data!,
                  selectable: true,
                ),
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class MyDescriptionString extends StatelessWidget {
  final String description;
  final ScrollController scrollController = ScrollController();
  final EdgeInsetsGeometry padding;

  MyDescriptionString(this.description, {this.padding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Scrollbar(
        child: SingleChildScrollView(
          controller: scrollController,
          child: MarkdownBody(
            data: description,
            selectable: true,
          ),
        ),
      ),
    );
  }
}

class MyDescriptionText extends StatelessWidget {
  final String description;
  final ScrollController scrollController = ScrollController();
  final EdgeInsetsGeometry padding;

  MyDescriptionText(this.description, {this.padding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Scrollbar(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Text(
            description,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

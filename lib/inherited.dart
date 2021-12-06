import 'package:flutter/material.dart';

class TitleProvider extends InheritedWidget {
  final String title;
  final String description;
  final Widget child;

  TitleProvider({
    required this.title,
    required this.description,
    required this.child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TitleProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TitleProvider>();

  static String? ofTitle(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TitleProvider>()?.title;

  static String? ofDescription(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TitleProvider>()?.description;
}

class IneritedRootLevelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('InheritedWidget'),
        ),
        body: SecondLevelWidget(),
      );
}

class SecondLevelWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => HelloWorldWrapperWidget();
}

class HelloWorldWrapperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HelloWorldTitleOnlyWidget(),
          HelloWorldDescriptionOnlyWidget(),
        ],
      );
}

class HelloWorldTitleOnlyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('buildTitle');
    final title =
        '${TitleProvider.ofTitle(context) ?? 'broken data'}\nSize: ${size.toString()}';

    print(size);

    return Text(
      title,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 40),
    );
  }
}

class HelloWorldDescriptionOnlyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('buildDescription');
    final description =
        '${TitleProvider.ofDescription(context) ?? 'broken data'}\nSize: ${size.toString()}';

    print(size);

    return Text(
      description,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 40),
    );
  }
}

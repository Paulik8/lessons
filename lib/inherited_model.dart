import 'package:flutter/material.dart';

class MyInheritedModel extends InheritedModel<String> {
  final String title;
  final String description;
  final Widget child;

  MyInheritedModel({
    required this.title,
    required this.description,
    required this.child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedModel oldWidget) =>
      title != oldWidget.title || description != oldWidget.description;

  static String? of(BuildContext context, String aspect) {
    final data =
        InheritedModel.inheritFrom<MyInheritedModel>(context, aspect: aspect);
    if (data == null) {
      return null;
    }
    if (aspect == 'title') {
      return data.title;
    } else if (aspect == 'description') {
      return data.description;
    }
  }

  @override
  bool updateShouldNotifyDependent(
          MyInheritedModel oldWidget, Set<String> dependencies) =>
      (dependencies.contains('title') && oldWidget.title != title) ||
      (dependencies.contains('description') &&
          oldWidget.description != description);
}

class IneritedRootLevelWidgetAnother extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SecondLevelWidgetAnother();
}

class SecondLevelWidgetAnother extends StatelessWidget {
  @override
  Widget build(BuildContext context) => HelloWorldWrapperWidgetAnother();
}

class HelloWorldWrapperWidgetAnother extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HelloWorldTitleOnlyWidgetAnother(),
          HelloWorldDescriptionOnlyWidgetAnother(),
        ],
      );
}

class HelloWorldTitleOnlyWidgetAnother extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('buildTitle');
    final title =
        '${MyInheritedModel.of(context, 'title') ?? 'broken data'}\nSize: ${size.toString()}';

    print(size);

    return Text(
      title,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontSize: 40),
    );
  }
}

class HelloWorldDescriptionOnlyWidgetAnother extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print('buildDescription');
    final description =
        '${MyInheritedModel.of(context, 'description') ?? 'broken data'}\nSize: ${size.toString()}';

    print(size);

    return Text(
      description,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.green, fontSize: 40),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'inherited.dart' as i;
import 'inherited_notifier.dart';
import 'many_levels_problem.dart';
import 'onboarding.dart';
import 'stateful.dart';
import 'stateful_lifecycle.dart';

enum Example {
  stateful,
  stateLifecycle,
  onboarding,
  manyLevels,
  inherited,
  inheritedNotifier,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final example = Example.onboarding;

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getExample(example),
    );
  }

  Widget _getExample(Example example) {
    switch (example) {
      case Example.stateful:
        return MyOwnWidget();
      case Example.stateLifecycle:
        return StatefulLifecycle(text: 'Hello, world!');
      case Example.manyLevels:
        return RootLevelWidget(title: 'Hello, world!');
      case Example.onboarding:
        return Onboarding();
      case Example.inherited:
        return i.TitleProvider(
          title: 'Hello, title!',
          description: 'Hello, description!',
          child: i.IneritedRootLevelWidget(),
        );
      case Example.inheritedNotifier:
        return InheritedNotifierExample();
    }
  }
}

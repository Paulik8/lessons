import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_rendering_example/inherited_model.dart';

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
  inheritedModel,
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final example = Example.inheritedModel;

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
      case Example.inheritedModel:
        return _InheritedModelPage();
      case Example.inheritedNotifier:
        return InheritedNotifierExample();
    }
  }
}

class _InheritedModelPage extends StatefulWidget {
  @override
  _InheritedModelPageState createState() => _InheritedModelPageState();
}

class _InheritedModelPageState extends State<_InheritedModelPage> {
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = 'Hello, title!';
  }

  void _updateTitle() => setState(() => _title = 'Title changed');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedModel'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _updateTitle,
            child: Container(
              color: Colors.green,
              height: 40,
            ),
          ),
          Expanded(
            child: MyInheritedModel(
              title: _title,
              description: 'Hello, description!',
              child: IneritedRootLevelWidgetAnother(),
            ),
          ),
        ],
      ),
    );
  }
}

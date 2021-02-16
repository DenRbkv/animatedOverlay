import 'package:flutter/material.dart';
import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_dropdown/animated_overlay_dropdown.dart';

import 'package:overlay_manager_animated_test/overlay_manager/overlay_manager.dart';

import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_impl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOverlayDropdown(
              uniqueId: '1',
              dropdownHeader: Container(
                width: 150.0,
                height: 50.0,
                color: Colors.green,
              ),
              dropdownContent: Container(
                height: 100.0,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 50.0),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                    'https://s.dou.ua/CACHE/images/img/static/companies/instagram_avatar_logo2_XutENMb/7df5537c994312d5f2a2b2776be0c7b0.png'),
                Text('Text in stack'),
              ],
            ),
            AnimatedOverlayDropdown(
              uniqueId: '2',
              dropdownHeader: Container(
                width: 150.0,
                height: 50.0,
                color: Colors.yellow,
              ),
              dropdownContent: Container(
                height: 100.0,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

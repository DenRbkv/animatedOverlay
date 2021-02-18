import 'package:flutter/material.dart';

import 'package:overlay_manager_animated_test/animated_overlay/animated_overlay_dropdown/animated_overlay_dropdown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  FocusNode firstOverlayNode;
  FocusNode secondOverlayNode;

  @override
  void initState() {
    super.initState();
    firstOverlayNode = FocusNode();
    secondOverlayNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          firstOverlayNode.unfocus();
          secondOverlayNode.unfocus();
        },
        focusColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedOverlayDropdown(
                  //uniqueId: '1',
                  contentHeight: 300.0,
                  //focusNode: firstOverlayNode,
                  dropdownHeader: Container(
                    width: 150.0,
                    height: 50.0,
                    color: Colors.green,
                  ),
                  dropdownContent: ColoredBox(color: Colors.purple.withOpacity(0.3)),
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
                const SizedBox(height: 50.0),
                AnimatedOverlayDropdown(
                  //uniqueId: '2',
                  contentHeight: 200.0,
                  //focusNode: secondOverlayNode,
                  dropdownHeader: Container(
                    width: 150.0,
                    height: 50.0,
                    color: Colors.yellow,
                  ),
                  dropdownContent: ColoredBox(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

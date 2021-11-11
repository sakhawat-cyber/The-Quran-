import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_holy_quran/customWidgets/appName.dart';
import 'package:the_holy_quran/customWidgets/calligraphy.dart';
import 'package:the_holy_quran/customWidgets/quranRailPNG.dart';
import 'package:the_holy_quran/darkModeControlar/darkThemeProvider.dart';
import 'package:the_holy_quran/view/myDrawer.dart';

class HomeScreen extends StatefulWidget {
  final double maxSlide;

  HomeScreen({required this.maxSlide});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();
  late bool _canBeDragged;

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseRight;
  }

  @override
  void disose() {
    animationController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / widget.maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;
    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<bool> _onWillPop() async {
    return (await (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: new Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: new Text("Are You Sure?"),
            actions: <Widget>[
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
              FlatButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: new Text(
                  "No",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ) as FutureOr<bool>?)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Material(
              color: themeChange.darkTheme ? Colors.grey[850] : Colors.white70,
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Transform.translate(
                      offset: Offset(
                          widget.maxSlide * (animationController.value - 1), 0),
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(
                              math.pi / 2 * (1 - animationController.value)),
                        alignment: Alignment.centerLeft,
                        child: MyDrawer(),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(
                          widget.maxSlide * animationController.value, 0),
                      child: Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(-math.pi / 2 * animationController.value),
                          alignment: Alignment.centerLeft,
                          child: MainScreen()),
                    ),
                    Positioned(
                      top: 4.0 + MediaQuery.of(context).padding.top,
                      left: width * 0.01 +
                          animationController.value * widget.maxSlide,
                      child: IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: toggle,
                        color:
                            themeChange.darkTheme ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      color: themeChange.darkTheme ? Colors.grey[700] : Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AppName(),
          Calligraphy(),
          QuranRail(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SuraBtn(),
                JuzzIndexBtn(),
                SajdaBtn(),
              ],
            ),
          ),
          AyahBottom(),
        ],
      ),
    );
  }
}

class SuraBtn extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class JuzzIndexBtn extends StatelessWidget {
  const JuzzIndexBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SajdaBtn extends StatelessWidget {
  const SajdaBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AyahBottom extends StatelessWidget {
  const AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

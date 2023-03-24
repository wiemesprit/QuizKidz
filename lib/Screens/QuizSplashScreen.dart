import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/AppWidget.dart';
import 'QuizDashboard.dart';
import 'QuizMain.dart';

class QuizSplashScreen extends StatefulWidget {
  @override
  _QuizSplashScreenState createState() => _QuizSplashScreenState();
}

class _QuizSplashScreenState extends State<QuizSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await initialize();
    sharedPreferences.getString('user') == null
        ? await 3.seconds.delay.then((value) => push(QuizMain(),
            pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true))
        : await 3.seconds.delay.then((value) => push(QuizDashboard(),
            pageRouteAnimation: PageRouteAnimation.Slide, isNewTask: true));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonCacheImageWidget("images/quiz/ic_background.png",
                height: 250, width: 250),
          ],
        ).withWidth(context.width()),
      ),
    );
  }
}

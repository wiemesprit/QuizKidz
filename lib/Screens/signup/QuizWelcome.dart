import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/AppWidget.dart';
import '../../utils/QuizColors.dart';
import '../../utils/QuizWidget.dart';
import '../QuizDashboard.dart';

class QuizWelcome extends StatefulWidget {
  static String tag = '/QuizWelcome';

  @override
  _QuizWelcomeState createState() => _QuizWelcomeState();
}

class _QuizWelcomeState extends State<QuizWelcome> {
  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);

    return Scaffold(
        backgroundColor: quiz_app_background,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
            child: Column(children: [
              Column(children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                    child: Column(children: [
                      commonCacheImageWidget(
                        "images/quiz/quiz.png",
                      ),
                      commonCacheImageWidget(
                        "images/quiz/bienvenue.png",
                      ),
                    ])),
                Container(
                    margin: EdgeInsets.fromLTRB(60, 90, 60, 0),
                    child: quizButton(
                        textContent: "Accéder à l'appli",
                        onPressed: () {
                          setState(
                            () {
                              QuizDashboard().launch(context);
                            },
                          );
                        }))
              ]),
            ]),
          ),
        )));
  }
}

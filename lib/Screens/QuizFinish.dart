import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/QuizController.dart';
import '../utils/AppWidget.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizWidget.dart';
import 'QuizDashboard.dart';


class QuizFinish extends StatefulWidget {
  static String tag = '/QuizWelcome';

  int points;
  String? quizAttemptId;
  QuizFinish({this.points = 0, required this.quizAttemptId});

  @override
  _QuizFinishState createState() => _QuizFinishState();
}

class _QuizFinishState extends State<QuizFinish> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);

    return Scaffold(
        backgroundColor: quiz_white,
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(children: [
            Column(children: [
              Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Column(children: [
                    commonCacheImageWidget(
                      "images/quiz/trophet.png",
                    ),
                  ])),
              Container(
                  margin: EdgeInsets.fromLTRB(60, 10, 60, 0),
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              quiz_colorPrimary),
                        ))
                      : quizButton(
                          textContent: "Obtenez mes ${widget.points} points",
                          onPressed: () {
                            setState(
                              () {
                                isLoading = true;
                                QuizController.instance
                                    .finishQuiz(widget.quizAttemptId ?? "")
                                    .then(
                                  (value) {
                                    isLoading = false;
                                    QuizController.instance.userQuizAnswerList
                                        .clear();
                                    QuizDashboard().launch(context);
                                  },
                                );
                              },
                            );
                          }))
            ]),
          ]),
        )));
  }
}

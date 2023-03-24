import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/QuizController.dart';
import '../data/models/Quiz.dart';
import '../data/models/QuizAttempt.dart';
import '../utils/AppWidget.dart';
import '../utils/Consts.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizConstant.dart';
import '../utils/QuizWidget.dart';
import 'QuizDetail.dart';


class QuizStart extends StatefulWidget {
  static String tag = '/QuizWelcome';
  QuizBodyRes? model;

  QuizStart({this.model});

  @override
  _QuizStartState createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    changeStatusColor(quiz_app_background);

    return Scaffold(
        backgroundColor: quiz_app_background,
        body: SafeArea(
            child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                           height: 200.0,
            width:390.0,
                          child:commonCacheImageWidget(
                              '${Consts.baseUrl}/uploads/${widget.model?.image}',
                              height: 200),
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: text(widget.model?.name ?? "",
                                isLongText: true,
                                fontFamily: fontBold,
                                isCentered: true,
                                fontSize: textSizeXLarge),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                            child: text(widget.model?.description ?? "",
                               isLongText: true,
                                fontFamily: fontBold,
                                isCentered: true,
                                fontSize: textSizeXLarge),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.fromLTRB(60, 90, 60, 60),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                quiz_colorPrimary),
                          ))
                        : quizButton(
                            textContent: "Commencez maintenant",
                            onPressed: () {
                              setState(
                                () {
                                  isLoading = true;
                                  QuizController.instance
                                      .createQuizAttempt(widget.model?.id ?? "")
                                      .then((value) {
                                    if (value is QuizAttemptBodyRes) {
                                      isLoading = false;

                                      if (value.alreadyPlayed == true) {
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  title: Row(children: [
                                                    Image.asset(
                                                      'images/quiz/alerte1.png',
                                                      width: 70,
                                                      height: 70,
                                                      fit: BoxFit.contain,
                                                    ),
                                                    Text(
                                                      'Vous avez déjà jouer ce quiz',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    )
                                                  ]),
                                                  content: Text(
                                                      "Vous n'allez pas reçevoir d'avantage des points",
                                                      style: TextStyle(
                                                          fontSize: 14)),
                                                  actions: [
                                                    TextButton(
                                                      child: Text(
                                                          "Rejouer commememe!"),
                                                      onPressed: () {
                                                        QuizDetail(
                                                          quizId:
                                                              value.id ?? "",
                                                          questions: widget
                                                                  .model
                                                                  ?.questions ??
                                                              [],
                                                          quizAlreadyPlayed:
                                                              true, quizimage: '', questionimage: '',
                                                        ).launch(context);
                                                      },
                                                    )
                                                  ],
                                                ));
                                      } else {
                                        QuizDetail(
                                          quizId: value.id ?? "",
                                          questions:
                                              widget.model?.questions ?? [],
                                          quizAlreadyPlayed: false, quizimage: '', questionimage: '',
                                        ).launch(context);
                                      }
                                    }
                                  });
                                },
                              );
                            }))
              ]),
        )));
  }
}

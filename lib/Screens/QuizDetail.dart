import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/QuizController.dart';
import '../data/models/Answer.dart';
import '../data/models/Question.dart';
import '../utils/AppWidget.dart';
import '../utils/Consts.dart';
import '../utils/QuizColors.dart';
import '../utils/QuizConstant.dart';
import 'QuizFinish.dart';
import 'QuizHome.dart';


class QuizDetail extends StatefulWidget {
  static String tag = '/QuizCards';
  String quizId;
  String quizimage;
  bool quizAlreadyPlayed;
  String questionimage;

  List<QuestionBodyRes>? questions = [];
  QuizDetail(
      {this.questions, required this.quizId, required this.quizimage,required this.questionimage, required this.quizAlreadyPlayed});
  @override
  _QuizDetailState createState() => _QuizDetailState();
}

class _QuizDetailState extends State<QuizDetail> {
  List<Widget> cardList = [];
  double progressValue = 0;
  int score = 0;
  void removeCards(index) {
    setState(() {
      cardList.removeAt(index);
      if (widget.questions != null) {
        progressValue = index / widget.questions!.length;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    cardList = _generateCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: quiz_app_background,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  child: Stack(alignment: Alignment.center, children: cardList),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        finish(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: quiz_colorPrimary,
                      ),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: textSecondaryColor.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          quiz_green,
                        ),
                      ).paddingAll(16),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  List<Widget> _generateCards() {
    List<Widget> cardList = [];

    for (int x = 0; x < (widget.questions?.length ?? 0); x++) {
      cardList.add(
        Positioned(
          top: x * 15,
          child: GestureDetector(
            child: Container(
                decoration: boxDecoration(
                    radius: 20, bgColor: quiz_white, showShadow: true),
                child: Column(
                  children: <Widget>[
                         Container(
                        height: 140.0,
                        width: 280.0,
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
                          child: Text(
                            widget.questions?[x].question ?? "",
                            style: TextStyle(
                                color: textSecondaryColor,
                                fontSize: textSizeNormal,
                                ),
                                textAlign: TextAlign.center
                          ),
                     
                        ),
                     
                       
                      ),
   Container(  
    margin: EdgeInsets.only(top:0),
                         // padding: EdgeInsets.fromLTRB(50,0, 50, 0),  
                           child:
                           
                          
                            SizedBox(
            height: 119.0,
            width:250.0,
         child: Image.network(
                            '${Consts.baseUrl}/uploads/${widget.questions?[x].questionImage}',
                            fit: BoxFit.cover,
          ),
                          ),),
               

                    
                    
                
                        
                    Container(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Column(
                          children: <Widget>[
                            for (var y = 0;
                                y < (widget.questions?[x].answers?.length ?? 0);
                                y++) ...{
                              QuizCardSelection(
                                quizId: widget.quizId,
                                questionId: widget.questions?[x].id,
                                questionImage: widget.questions?[x].questionImage,
                                answer: widget.questions?[x].answers?[y],
                                questionIndex: x,
                                onSelectAnswer: () {
                                  setState(() {
                                    //showResult = true;
                                  });
                                },
                                gainedScore: (gain) {
                                  setState(() {
                                    score += gain;
                                  });
                                },
                                moveToNext: () {
                                  removeCards(x);
                                },
                                finishQuiz: () {
                                  if (widget.quizAlreadyPlayed) {
                                    QuizHome().launch(getContext);
                                  } else {
                                    QuizFinish(
                                      points: score,
                                      quizAttemptId: widget.quizId,
                                    ).launch(getContext);
                                  }
                                },
                              )
                            },
                          ],
                        ))
                  ],
                )),
          ),
        ),
      );
    }
    return cardList;
  }
}

class QuizCardSelection extends StatefulWidget {
  AnswerBodyRes? answer;
  String? quizId;
  String? questionId;
  String? questionImage;

  Function onSelectAnswer;
  Function moveToNext;
  Function finishQuiz;
  Function(int) gainedScore;

  int questionIndex;
  QuizCardSelection(
      {required this.answer,
      required this.questionId,
      required this.questionImage,
      required this.quizId,
      required this.questionIndex,
      required this.onSelectAnswer,
      required this.moveToNext,
      required this.finishQuiz,
      required this.gainedScore});

  @override
  State<QuizCardSelection> createState() => _QuizCardSelectionState();
}

class _QuizCardSelectionState extends State<QuizCardSelection> {
  bool showAnswers = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (QuizController.instance.userQuizAnswerList.firstWhere(
                (element) => element?.questionId == widget.questionId,
                orElse: () => null) ==
            null) {
          setState(() {
            showAnswers = true;

            QuizController.instance.userQuizAnswerList.add(UserQuizAnswer(
                questionId: widget.questionId ?? "",
                answeId: widget.answer?.id ?? ""));
          });

          if (widget.answer?.isCorrect ?? false) {
            widget.gainedScore(widget.answer?.score ?? 0);
          }

          QuizController.instance
              .addAnswerAttempt(widget.quizId ?? "", widget.questionId ?? "",
                  widget.answer?.id ?? "")
              .then((value) {
            //if (value is AnswerAttemptBodyRes) {}
          });

          Timer(Duration(seconds: 2), () {
            if (widget.questionIndex == 0) {
              widget.finishQuiz();
            } else {
              widget.moveToNext();
            }
          });
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: showAnswers
            ? boxDecoration(
                showShadow: false,
                bgColor: (widget.answer?.isCorrect ?? false)
                    ? quiz_color_green.withOpacity(0.1)
                    : quiz_color_red.withOpacity(0.1),
                radius: 10,
                color: (widget.answer?.isCorrect ?? false)
                    ? quiz_color_green
                    : quiz_color_red)
            : boxDecoration(
                showShadow: false,
                //quiz_edit_background
                bgColor: quiz_edit_background,
                radius: 10,
                color: quiz_edit_background),
        padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        width: 320,
        child: Center(
          child:
              text(widget.answer?.answer, textColor: quiz_textColorSecondary),
        ),
      ),
    );
  }
}

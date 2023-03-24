import 'Answer.dart';

class QuestionBodyRes {
  String? id;
  String? question;
  String? questionImage;
  List<AnswerBodyRes>? answers;

  QuestionBodyRes({this.id, this.question,this.questionImage, this.answers});
  factory QuestionBodyRes.fromJson(dynamic json) {
    return QuestionBodyRes(
        id: json['_id'] as String,
        question: json['question'] as String,
        questionImage: json['image'] as String,
        answers: List<AnswerBodyRes>.from((json['answers'] as List<dynamic>)
            .map((e) => AnswerBodyRes.fromJson(e))).toList());
  }
}

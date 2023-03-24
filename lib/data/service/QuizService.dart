import 'dart:convert';
import 'dart:io';
import '../../utils/Consts.dart';
import '../models/Category.dart';
import '../models/Quiz.dart';
import '../models/QuizAttempt.dart';

class QuizService {
  getAllQuizByCat(String id) async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('${Consts.getAllQuizByCat}${id}'));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return GetAllQuizSuccessRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  getAllQuiz() async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('${Consts.getAllQuiz}'));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return GetAllQuizSuccessRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  getAllQuizAttempt(userId) async {
    var httpClient = HttpClient();

    try {
      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse('${Consts.getAllQuizAttempt}/${userId}'));
      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return GetAllQuizAttemptSuccessRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  createQuizAttempt(data) async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(Consts.addQuizAttempt));

      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode(data)));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return QuizAttemptBodyRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  finishQuizAttempt(data) async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(Consts.finishQuiz));
      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode(data)));

      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return QuizAttemptBodyRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  addAnswerAttempt(data) async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse(Consts.addAnswerAttempt));

      request.headers.set('content-type', 'application/json');

      request.add(utf8.encode(json.encode(data)));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return AnswerAttemptBodyRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {
      print(errror);
    }
  }
}

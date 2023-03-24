import 'dart:convert';
import 'dart:io';
import '../../utils/Consts.dart';
import '../models/Category.dart';
import '../models/User.dart';
import 'package:http/http.dart' as http;

class ProfileService {
  getMyProfile(String userId) async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('${Consts.getUserById}${userId}'));
      HttpClientResponse response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        print(stringData);
        return UserBodyRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  getBadges() async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('${Consts.getAllBadges}'));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return GetAllBadgeBodyRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }

  updateProfile({required String userId, Map<String, dynamic>? data, File? image}) async {
    var httpClient = HttpClient();
print("from service");
    try {
      var uri = Uri.parse('http://localhost:3000/api/v1/users/update/63e0f53fc6aa5056506b6721');

      var multipartFile;

      var multipartRequest = http.MultipartRequest('PATCH', uri);
      if (image != null) {
        multipartFile = await http.MultipartFile.fromPath('image', image.path);
      }

      if (data != null) {
        var formData = Map<String, String>.from(data.cast<String, dynamic>());
        multipartRequest.fields.addAll(formData);
      }
      if (multipartFile != null) {
        multipartRequest.files.add(multipartFile);
      }

      var response = await multipartRequest.send();
      if (response.statusCode == 200) {

        final stringData = await response.stream.transform(utf8.decoder).join();
        print(UserBodyRes.fromJson(json.decode(stringData)));
        return UserBodyRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.stream.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (error) {
      print(error);
    } finally {
      httpClient.close();
    }
  }
}

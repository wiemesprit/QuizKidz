import 'dart:convert';
import 'dart:io';
import '../../utils/Consts.dart';
import '../models/Category.dart';

class CategoryService {
  getAllCategory(String idUser) async {
    var httpClient = HttpClient();
    try {
      HttpClientRequest request = await httpClient
          .getUrl(Uri.parse('${Consts.getAllCategories}/${idUser}'));

      HttpClientResponse response = await request.close();

      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        return GetAllCategorySuccessRes.fromJson(json.decode(stringData));
      } else {
        final stringData = await response.transform(utf8.decoder).join();
        return ErrorBodyRes.fromJson(json.decode(stringData));
      }
    } catch (errror) {}
  }
}

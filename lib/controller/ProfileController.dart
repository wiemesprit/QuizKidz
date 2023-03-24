import 'dart:io' as io;

import 'package:nb_utils/nb_utils.dart';
import '../data/models/User.dart';
import '../data/service/ProfileService.dart';

class ProfileController {
  final ProfileService profileService = ProfileService();
  ProfileController() {}
  static final instance = ProfileController();

  Future<UserBodyRes?> getMyProfile() async {
    await initialize();
    var res = await profileService
        .getMyProfile(await sharedPreferences.getString('user') ?? "");
print ("from updateImage()");
    if (res is UserBodyRes) {
      return res;
    } else {
      return null;
    }
  }

  Future<List<BadgeBodyRes>?> getBadges() async {
    var res = await profileService.getBadges();

    if (res is GetAllBadgeBodyRes) {
      return res.badges;
    } else {
      return null;
    }
  }

  Future<UserBodyRes?> updateProfile(
      {required String userId,
      Map<String, dynamic>? data,
      io.File? image}) async {
        print ("from controller()");
    var res = await profileService.updateProfile(
        userId: userId, data: data, image: image);
    return res;
  }
}

import 'package:montageapp/features/random_user/data/model/user_model.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class UserAssertions {
  final List _assetsMaleUrl = [
    "assets/man_1.png",
    "assets/man_2.png",
    "assets/man_3.png",
    "assets/man_4.png",
    "assets/man_5.png",
    "assets/man_6.png",
    "assets/man_7.png"
  ];

  final List _assetsFemaleUrl = [
    "assets/woman_1.png",
    "assets/woman_2.png",
    "assets/woman_3.png",
    "assets/woman_4.png",
    "assets/woman_5.png",
    "assets/woman_6.png",
    "assets/woman_7.png"
  ];

  bool assertUserModel(UserModel actual, UserModel expected) {
    return _assertHelper(actual, expected);
  }

  bool assertUser(User actual, User expected) {
    return _assertHelper(actual, expected);
  }

  bool _assertHelper(var actual, var expected) {
    bool validAssertion = true;
    if (actual.name != expected.name) validAssertion = false;
    if (actual.email != expected.email) validAssertion = false;
    if (actual.userName != expected.userName) validAssertion = false;
    if (actual.password != expected.password) validAssertion = false;
    if (actual.address != expected.address) validAssertion = false;
    if (!(_assertImgUrlHelper(actual.gender, actual.imgUrl)))
      validAssertion = false;
    return validAssertion;
  }

  bool _assertImgUrlHelper(String gender, String imgUrl) {
    if (gender == "male") {
      return _assetsMaleUrl.contains(imgUrl);
    } else {
      return _assetsFemaleUrl.contains(imgUrl);
    }
  }
}

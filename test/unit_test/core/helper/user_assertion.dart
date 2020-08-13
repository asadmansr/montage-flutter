import 'package:montageapp/features/random_user/data/model/user_model.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

import '../dataset/test_data.dart';

class UserAssertions {
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
      return assetsMaleUrl.contains(imgUrl);
    } else {
      return assetsFemaleUrl.contains(imgUrl);
    }
  }
}

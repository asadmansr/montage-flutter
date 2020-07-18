import 'package:montageapp/features/random_user/data/model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUser();
}

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class Params extends Equatable {
  final User user;

  Params({@required this.user});

  @override
  List<Object> get props => [user];
}

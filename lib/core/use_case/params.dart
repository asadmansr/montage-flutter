import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:montageapp/features/random_user/domain/entity/user.dart';

class Params extends Equatable {
  final List<User> list;

  Params({@required this.list});

  @override
  List<Object> get props => list;
}

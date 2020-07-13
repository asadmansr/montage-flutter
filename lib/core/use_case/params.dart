import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Params extends Equatable {
  final String params;

  Params({@required this.params});

  @override
  List<Object> get props => [params];
}

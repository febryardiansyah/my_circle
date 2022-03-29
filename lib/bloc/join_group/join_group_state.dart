part of 'join_group_cubit.dart';

@immutable
abstract class JoinGroupState {}

class JoinGroupInitial extends JoinGroupState {}
class JoinGroupLoading extends JoinGroupState {}
class JoinGroupSuccess extends JoinGroupState {
  final String msg;

  JoinGroupSuccess(this.msg);
}
class JoinGroupFailure extends JoinGroupState {
  final String msg;

  JoinGroupFailure(this.msg);
}

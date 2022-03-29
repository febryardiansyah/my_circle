part of 'create_group_cubit.dart';

@immutable
abstract class CreateGroupState {}

class CreateGroupInitial extends CreateGroupState {}
class CreateGroupLoading extends CreateGroupState {}
class CreateGroupSuccess extends CreateGroupState {
  final String msg;

  CreateGroupSuccess(this.msg);
}
class CreateGroupFailure extends CreateGroupState {
  final String msg;

  CreateGroupFailure(this.msg);
}

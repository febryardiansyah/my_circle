part of 'get_groups_cubit.dart';

abstract class GetGroupsState extends Equatable {
  const GetGroupsState();
  @override
  List<Object> get props => [];
}

class GetGroupsInitial extends GetGroupsState {}
class GetGroupsLoading extends GetGroupsState {}
class GetGroupsSuccess extends GetGroupsState {
  final List<GroupModel>? data;

  GetGroupsSuccess({this.data});

  @override
  List<Object> get props => [data!];
}
class GetGroupsFailure extends GetGroupsState {
  final String msg;

  GetGroupsFailure(this.msg);
  @override
  List<Object> get props => [msg];
}

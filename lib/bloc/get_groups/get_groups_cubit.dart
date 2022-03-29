import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_circle/model/group_model.dart';
import 'package:my_circle/model/user_model.dart';
import 'package:my_circle/repositories/group_repo.dart';

part 'get_groups_state.dart';

class GetGroupsCubit extends Cubit<GetGroupsState> {
  GetGroupsCubit() : super(GetGroupsInitial());
  final _repo = GroupRepo();

  Future<void> fetchGroups()async{
    emit(GetGroupsLoading());
    try{
      final _res = await _repo.getGroups();
      if (_res.status!) {
        final _data = List<GroupModel>.from(_res.data.map((x)=>GroupModel.fromMap(x.data())));
        emit(GetGroupsSuccess(data: _data));
      } else {
        emit(GetGroupsFailure(_res.message!));
      }
    }catch(e){
      print(e);
      emit(GetGroupsFailure(e.toString()));
    }
  }
}

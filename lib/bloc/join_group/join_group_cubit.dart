import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_circle/repositories/group_repo.dart';

part 'join_group_state.dart';

class JoinGroupCubit extends Cubit<JoinGroupState> {
  JoinGroupCubit() : super(JoinGroupInitial());
  final _repo = GroupRepo();

  Future<void> joinGroup({required String groupCode})async{
    emit(JoinGroupLoading());
    try{
      final _res = await _repo.joinGroup(groupCode: groupCode);
      if (_res.status!) {
        emit(JoinGroupSuccess(_res.message!));
      } else {
        emit(JoinGroupFailure(_res.message!));
      }
    }catch(e){
      print(e);
      emit(JoinGroupFailure(e.toString()));
    }
  }
}

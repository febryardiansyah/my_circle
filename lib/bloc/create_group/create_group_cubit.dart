import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_circle/repositories/group_repo.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupInitial());
  final _repo = GroupRepo();

  Future<void> createGroup({required String groupName})async{
    emit(CreateGroupLoading());
    try{
      final _res = await _repo.createGroup(groupName: groupName);
      if (_res.status!) {
        emit(CreateGroupSuccess(_res.message!));
      } else {
        emit(CreateGroupFailure(_res.message!));
      }
    }catch(e){
      print(e);
      emit(CreateGroupFailure(e.toString()));
    }
  }
}

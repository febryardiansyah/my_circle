import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_circle/repositories/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _repo = AuthRepo();

  Future<void> register({required String name,required String email,required String password})async{
    emit(RegisterLoading());
    try{
      final _res = await _repo.register(name: name, email: email, password: password);
      if (_res.status!) {
        emit(RegisterSuccess(msg: _res.message!));
      } else {
        emit(RegisterFailure(msg: _res.message!));
      }
    }catch(e){
      print(e);
      emit(RegisterFailure(msg: e.toString()));
    }
  }
}

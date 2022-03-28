import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_circle/repositories/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _repo = AuthRepo();

  Future<void> login({required String email,required String password})async{
    emit(LoginLoading());
    try{
      final _res = await _repo.login(email: email, password: password);
      if (_res.status!) {
        emit(LoginSuccess(_res.message!,_res.data as String));
      } else {
        emit(LoginFailure(_res.message!));
      }
    }catch(e){
      print(e);
      emit(LoginFailure(e.toString()));
    }
  }
}

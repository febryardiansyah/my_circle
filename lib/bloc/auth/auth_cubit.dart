import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_circle/bloc/login/login_cubit.dart';
import 'package:my_circle/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _repo = AuthRepo();
  final LoginCubit loginCubit;
  StreamSubscription? _loginSubscription;

  AuthCubit(this.loginCubit) : super(AuthInitial()){
    // listen login cubit changes
    _loginSubscription = loginCubit.stream.listen((LoginState state) {
      // check if login cubit state is success
      if (state is LoginSuccess) {
        print('LOGGED IN TOKEN ==> ${state.token}');
        // trigger loggedIn method
        loggedIn(token: state.token);
      }
    });
  }

  // call when app started
  Future<void> appStarted()async{
    try{
      bool hasToken = await _repo.hasToken();
      print('HAS TOKEN ??? $hasToken');
      if (hasToken) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnAuthenticated());
      }
    }catch(e){
      print(e);
      emit(AuthUnAuthenticated());
    }
  }

  // call when login cubit state is success
  Future<void> loggedIn({required String token})async{
    try{
      await _repo.persistToken(token);
      emit(AuthAuthenticated());
    }catch(e){
      print(e);
      emit(AuthUnAuthenticated());
    }
  }

  @override
  Future<void> close() {
    _loginSubscription?.cancel();
    return super.close();
  }
}

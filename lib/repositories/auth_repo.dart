import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_circle/model/response_model.dart';
import 'package:my_circle/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_circle/utils/base_string.dart';


class AuthRepo {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FlutterSecureStorage();

  Future<ResponseModel> register({required String name, required String email, required String password})async{
    try{
      UserCredential _user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(_user.user.toString());
      final _userData = UserModel(name: name, email: email,);
      await _fireStore.collection('users').doc(_user.user?.uid).set(_userData.toMap());
      return ResponseModel(
        status: true,
        message: 'Register Success',
      );
    }on FirebaseAuthException catch(e){
      print(e.code);
      return ResponseModel(
        status: false,
        message: e.message,
      );
    }on FirebaseException catch(e){
      return ResponseModel(
        status: false,
        message: e.message,
      );
    }
  }

  Future<ResponseModel> login({required String email, required String password})async{
    try{
      UserCredential _user = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('UID ?? ${_user.user!.uid}');
      return ResponseModel(
        status: true,
        message: 'Login Success',
        data: _user.user!.uid,
      );
    }on FirebaseAuthException catch(e){
      print(e.code);
      return ResponseModel(
        status: false,
        message: e.message,
      );
    }on FirebaseException catch(e){
      return ResponseModel(
        status: false,
        message: e.message,
      );
    }
  }

  Future<void> persistToken(String uid)async{
    await _storage.write(key: BaseString.keyToken, value: uid);
  }

  Future<String?> getToken() async {
    String? token =  await _storage.read(key: BaseString.keyToken);
    return token;
  }

  Future<bool> hasToken()async{
    String? token = await getToken();
    return token != null;
  }
}
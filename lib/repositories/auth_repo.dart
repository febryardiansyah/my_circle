import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_circle/model/response_model.dart';
import 'package:my_circle/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_circle/utils/base_string.dart';


class AuthRepo {
  //initialize variable
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FlutterSecureStorage();

  Future<ResponseModel> register({required String name, required String email, required String password})async{
    try{
      //create user with email & password
      UserCredential _user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(_user.user.toString());
      // store data to model
      final _userData = UserModel(name: name, email: email,id: _user.user!.uid);
      // store model to firestore
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
      // sign in with email password
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
    // save token
    await _storage.write(key: BaseString.keyToken, value: uid);
  }

  Future<String?> getToken() async {
    // get token
    String? token =  await _storage.read(key: BaseString.keyToken);
    return token;
  }

  Future<bool> hasToken()async{
    String? token = await getToken();
    // check if token not null
    return token != null;
  }

  Future<void> removeToken()async{
    // delete token
    await _storage.delete(key: BaseString.keyToken);
  }
}
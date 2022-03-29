import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_circle/model/response_model.dart';
import 'package:my_circle/utils/base_string.dart';

class GroupRepo{
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FlutterSecureStorage();

  Future<ResponseModel> getGroups()async{
    try{
      final _token = await _storage.read(key: BaseString.keyToken);
      final _res = await _fireStore.collection('users').doc(_token).get();
      return ResponseModel(
        status: true,message: 'Success',
        data: _res.data(),
      );
    }on FirebaseException catch(e){
      print(e);
      return ResponseModel(
        status: false,message: e.message,
      );
    }
  }
}
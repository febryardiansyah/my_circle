import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_circle/model/group_model.dart';
import 'package:my_circle/model/response_model.dart';
import 'package:my_circle/model/user_model.dart';
import 'package:my_circle/utils/base_string.dart';
import 'package:uuid/uuid.dart';

class GroupRepo{
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FlutterSecureStorage();
  final _uuid = Uuid();

  Future<ResponseModel> getGroups()async{
    try{
      final _token = await _storage.read(key: BaseString.keyToken);
      final _res = await _fireStore.collection('users').doc(_token).collection('groups').orderBy('createdAt',descending: true).get();
      return ResponseModel(
        status: true,message: 'Success',
        data: _res.docs,
      );
    }on FirebaseException catch(e){
      print(e);
      return ResponseModel(
        status: false,message: e.message,
      );
    }
  }

  Future<ResponseModel> createGroup({required String groupName,})async{
    try{
      String id = _uuid.v1().split('-').first;
      final token = await _storage.read(key: BaseString.keyToken);
      final data = GroupModel(
        groupName: groupName,
        groupId: id,
        groupProfile: BaseString.groupProfile,
        createdAt: DateTime.now(),
      );
      final user = await _fireStore.collection('users').doc(token).get();
      UserModel userData = UserModel.fromMap(user.data()!);
      await _fireStore.collection('users').doc(token).collection('groups').doc(id).set(data.toMap());
      await _fireStore.collection('groups').doc(id).set(data.toMap());
      await _fireStore.collection('groups').doc(id).collection('members').doc(token).set(userData.toMap());
      return ResponseModel(
        status: true,message: 'Group created successfully',
      );
    }on FirebaseException catch(e){
      return ResponseModel(
        status: false,message: e.message,
      );
    }
  }
}
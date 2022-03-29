class GroupModel {
  String? groupId;
  String? groupName;
  String? groupProfile;

  GroupModel({this.groupId, this.groupName, this.groupProfile});

  factory GroupModel.fromMap(Map<String,dynamic>json){
    return GroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupProfile: json['groupProfile'],
    );
  }
}
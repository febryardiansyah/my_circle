class GroupModel {
  String? groupId;
  String? groupName;
  String? groupProfile;
  DateTime? createdAt;

  GroupModel({this.groupId, this.groupName, this.groupProfile,this.createdAt});

  factory GroupModel.fromMap(Map<String,dynamic>json){
    return GroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupProfile: json['groupProfile'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String,dynamic> toMap()=>{
    'groupId':groupId,
    'groupName':groupName,
    'groupProfile':groupProfile,
    'createdAt':createdAt?.toIso8601String(),
  };
}
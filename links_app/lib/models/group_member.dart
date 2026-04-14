class GroupMember {
  final int id;
  final int groupId;
  final int userId;

  GroupMember({
    required this.id,
    required this.groupId,
    required this.userId,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json['id'],
      groupId: json['groupId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'groupId': groupId,
    'userId': userId,
  };
}
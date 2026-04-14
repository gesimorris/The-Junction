class Group {
  final int id;
  final int eventId;
  final int maxMembers;
  final String? groupStatus;
  final DateTime createdDate;
  final int creatorId;

  Group({
    required this.id,
    required this.eventId,
    required this.maxMembers,
    this.groupStatus,
    required this.createdDate,
    required this.creatorId,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      eventId: json['eventId'],
      maxMembers: json['maxMembers'],
      groupStatus: json['groupStatus'],
      createdDate: DateTime.parse(json['createdDate']),
      creatorId: json['creatorId'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'eventId': eventId,
    'maxMembers': maxMembers,
    'groupStatus': groupStatus,
    'createdDate': createdDate.toIso8601String(),
    'creatorId': creatorId,
  };
}
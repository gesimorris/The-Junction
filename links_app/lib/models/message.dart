class Message {
  final int id;
  final String? messageText;
  final int userId;
  final int groupId;
  final DateTime messageDate;

  Message({
    required this.id,
    this.messageText,
    required this.userId,
    required this.groupId,
    required this.messageDate,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      messageText: json['messageText'],
      userId: json['userId'],
      groupId: json['groupId'],
      messageDate: DateTime.parse(json['messageDate']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'messageText': messageText,
    'userId': userId,
    'groupId': groupId,
    'messageDate': messageDate.toIso8601String(),
  };
}
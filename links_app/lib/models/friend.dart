class Friend {
  final int id;
  final int senderId;
  final int receiverId;
  final String? status;
  final DateTime createdAt;

  Friend({
    required this.id,
    required this.senderId,
    required this.receiverId,
    this.status,
    required this.createdAt,
  });

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'senderId': senderId,
    'receiverId': receiverId,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
  };
}
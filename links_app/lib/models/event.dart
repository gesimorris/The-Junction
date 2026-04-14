class Event {
  final int id;
  final String? name;
  final String? location;
  final DateTime date;
  final int numOfAttendees;
  final int maxAttendees;
  final String? description;

  Event({
    required this.id,
    this.name,
    this.location,
    required this.date,
    required this.numOfAttendees,
    required this.maxAttendees,
    this.description,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      numOfAttendees: json['numOfAttendees'],
      maxAttendees: json['maxAttendees'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'date': date.toIso8601String(),
    'numOfAttendees': numOfAttendees,
    'maxAttendees': maxAttendees,
    'description': description,
  };
}
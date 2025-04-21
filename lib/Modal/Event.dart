class Event {
  static const String collectionName = 'Event';
  String id;

  String title;

  String description;

  String eventName;
  String image;
  String time;
  DateTime date;

  bool isFavorite;

  Event(
      {required this.eventName,
      this.id = '',
      required this.title,
      required this.description,
      required this.image,
      required this.date,
      required this.time,
      this.isFavorite = false});

  Event.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          image: data['image'],
          eventName: data['eventName'],
          time: data['time'],
          date: DateTime.fromMillisecondsSinceEpoch(data['date']),
          isFavorite: data['isFavorite'],
        );

  Map<String, dynamic> tofireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'eventName': eventName,
      'time': time,
      'date': date.millisecondsSinceEpoch,
      'isFavorite': isFavorite,
    };
  }
}

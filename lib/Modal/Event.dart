class Event {
  static const String collectionName = 'Event';
  String id;
  String title;
  String description;
  String eventName;
  String image;
  String time;
  DateTime date;
  double lat;
  double long;
  String city;
  String country;
  bool isFavorite;

  Event(
      {required this.eventName,
      this.id = '',
      required this.title,
      required this.description,
      required this.image,
      required this.date,
      required this.time,
      this.isFavorite = false,this.lat = 0.0,
        this.long = 0.0,
        this.city = 'Unknown',
        this.country = 'Unknown',});



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
         lat: data['lat'] ?? 37.42796133580664,
         long: data['long'] ?? -122.085749655962,
         city: data['city'] ?? 'Unknown',
      country: data['country'] ?? 'Unknown',
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
      'lat': lat,
      'long': long,
      'city': city,
      'country': country,
    };
  }
}

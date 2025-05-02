class MyUser {
  static const String collectionName = 'MyUser';
  String id;
  String email;
  String name;

  MyUser({required this.id, required this.name, required this.email});

  // object to json
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

//json to object
  MyUser.fromFireStore(Map<String, dynamic> date)
      : this(
          id: date['id'] as String,
          name: date['name'] as String,
          email: date['email'] as String,
        );
}

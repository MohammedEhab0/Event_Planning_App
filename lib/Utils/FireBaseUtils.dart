import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:event_planning_app/Modal/MyUser.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseUtils {
  static CollectionReference<Event> getEventColleection(String uId) {
    return getUsersCollection().doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
            fromFirestore: (snapshot, options) =>
                Event.fromFireStore(snapshot.data()!),
            toFirestore: (event, options) => event.tofireStore());
  }
  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);

}
static Future<MyUser?> readUserFromFireStore(String id)async{
   var querySnapShot= await getUsersCollection().doc(id).get();
   return querySnapShot.data();
}
  static Future<Event?> readEventFromFireStore(String uId,String id)async{
    var querySnapShot= await getEventColleection(uId).doc(id).get();
    return querySnapShot.data();
  }
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromFireStore(snapshot.data()!),
            toFirestore: (myUser, options) => myUser.toFireStore());
  }

  static Future<void> addEventToFireStore(Event event,String uId) {
    var eventCollection = getEventColleection(uId);
    DocumentReference<Event> docRef = eventCollection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}

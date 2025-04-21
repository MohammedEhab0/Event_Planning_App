import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/Modal/Event.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseUtils{
  static CollectionReference<Event> getEventColleection(){
    return FirebaseFirestore.instance.collection(Event.collectionName).
    withConverter<Event>(
        fromFirestore: (snapshot,options)=>Event.fromFireStore(snapshot.data()!),
        toFirestore:(event,options)=>event.tofireStore() );
  }
  static Future<void> addEventToFireStore (Event event){
   var  eventCollection = getEventColleection();
   DocumentReference<Event> docRef=eventCollection.doc();
   event.id=docRef.id;
   return docRef.set(event);

  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/models/my_user.dart';
import '../../features/home/models/event.dart';

class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, _) => MyUser.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  static CollectionReference<Event> getEventsCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  static Future<void> addUserToFirestore(MyUser user) async {
    return getUsersCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUserFromFirestore(String id) async {
    var docSnapshot = await getUsersCollection().doc(id).get();
    return docSnapshot.data();
  }

  static Future<void> addEventToFirestore(Event event) {
    var collection = getEventsCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Stream<QuerySnapshot<Event>> getEventsStream(String category) {
    if (category == 'All') {
      return getEventsCollection().orderBy('dateTime').snapshots();
    }
    return getEventsCollection()
        .where('category', isEqualTo: category)
        .orderBy('dateTime')
        .snapshots();
  }

  static Future<void> updateEventFavoriteStatus(String eventId, bool isFavorite) {
    return getEventsCollection().doc(eventId).update({'isFavorite': isFavorite});
  }

  static Stream<QuerySnapshot<Event>> getFavoriteEventsStream() {
    return getEventsCollection()
        .where('isFavorite', isEqualTo: true)
        .orderBy('dateTime')
        .snapshots();
  }

  static Future<UserCredential> register(String email, String password) async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> login(String email, String password) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

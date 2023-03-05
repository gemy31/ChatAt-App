import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../model/message.dart';
import '../model/my_user.dart';
import '../model/room.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: ((snapshot, option) =>
                MyUser.fromJson(snapshot.data()!)),
            toFirestore: ((user, option) => user.toJson()));
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: ((snapshot, option) =>
                Room.fromJson(snapshot.data()!)),
            toFirestore: (room, option) => room.toJson());
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return getRoomCollection()
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
            fromFirestore: ((snapshot, option) =>
                Message.fromJson(snapshot.data()!)),
            toFirestore: (message, option) => message.toJson());
  }

  static Future<void> createUser(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String userId) async {
    var userDocSnapShot = await getUserCollection().doc(userId).get();
    return userDocSnapShot.data();
  }

  static Future<void> createRoomToFirebase(
      String title, String description, String categoryId) {
    var collection = getRoomCollection();
    var docRef = collection.doc();
    Room room = Room(
        id: docRef.id,
        title: title,
        description: description,
        categoryId: categoryId);
    return docRef.set(room);
  }

  // static Future<List<Room>> getRooms()async{
  //   var querySnapShot = await getRoomCollection().get();
  //   return querySnapShot.docs.map((doc) => doc.data()).toList();
  // }

  static Stream<QuerySnapshot<Room>> getAllRooms() {
    return getRoomCollection().snapshots();
  }

  static Future<void> insertMessageToFireBase(Message message) {
    var roomMessages = getMessageCollection(message.roomId);
    var docRef = roomMessages.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessages(String roomId) {
    return getMessageCollection(roomId).orderBy('dateTime').snapshots();
  }
}

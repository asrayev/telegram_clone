import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import '../models/chat_room_model.dart';

class ChatRepo {
  final FirebaseFirestore _firestore;

  ChatRepo({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addChat({required ChatModel chatModel, required String newDoc}) async {
    dynamic docRef = _firestore.collection("chats").doc(newDoc);
    dynamic docRef2 = _firestore.collection("chats").doc("${newDoc.substring(29,57)}_${newDoc.substring(0,28)}");
    try {
      docRef2.get().then((doc) async =>
      {
        if(doc.exists){}
        else{
          await _firestore.collection("chats").doc(newDoc).set(chatModel.toJson()),}
      });
      docRef.get().then((doc) async => {
      if (doc.exists) {}
      else {
          await _firestore.collection("chats").doc(newDoc).set(chatModel.toJson()),
    }});}
    on FirebaseException catch (er) {
    }
  }

  Future<void> deleteChat({required String docId}) async {
    dynamic docRef = _firestore.collection("chats").doc(docId);
    dynamic docRef2 = _firestore.collection("chats").doc("${docId.substring(29,57)}_${docId.substring(0,28)}");
    try {
      docRef2.get().then((doc) async =>
      {
        if(doc.exists){}
        else{
          await _firestore.collection("chats").doc(docRef2).delete(),
        }});
      docRef.get().then((doc) async => {
        if (doc.exists) {}
        else {
          await _firestore.collection("chats").doc(docRef).delete(),
        }});}
    on FirebaseException catch (er) {}
    }


  Future<void>? addMessage({required String chatsId,required ChatRoomModel chatRoomModel}) async {
    dynamic docRef = _firestore.collection("chats").doc(chatsId);
    dynamic docRef2 = _firestore.collection("chats").doc("${chatsId.substring(29,57)}_${chatsId.substring(0,28)}");
    try {
      docRef2.get().then((doc) async =>
      {
        if(doc.exists){
          await _firestore.collection("chats")
              .doc(docRef2.toString().substring(46,103))
              .collection("chatRoom")
              .add(chatRoomModel.toJson())
        }
        else{}
      });
      docRef.get().then((doc) async => {
        if (doc.exists) {
          await _firestore.collection("chats")
              .doc(docRef.toString().substring(46,103))
              .collection("chatRoom")
              .add(chatRoomModel.toJson()),
        }
        else {}
      });

    } on FirebaseException catch (er) {}
  }


  Future<Stream<List<ChatModel>>?> getChats({required String docId}) async {
    dynamic docRef = await _firestore.collection("chats").doc(docId);
    dynamic docRef2 = await _firestore.collection("chats").doc("${docId.substring(29,57)}_${docId.substring(0,28)}");
    dynamic stream;
    try {
      docRef2.get().then((doc) async =>
      {
        if(doc.exists){
        }
        else{
          stream = _firestore.collection("chats").where("doc_id", isEqualTo: docRef2.toString().substring(46,103)).snapshots().map(
                (querySnapshot) => querySnapshot.docs
                .map((doc) => ChatModel.fromJson(doc.data()))
                .toList(),
          )
        }
      });
      docRef.get().then((doc) async => {
        if (doc.exists) {
        }
        else {
          stream = _firestore.collection("chats").where("doc_id", isEqualTo: docRef.toString().substring(46,103)).snapshots().map(
              (querySnapshot) => querySnapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList())
        }
      });
      return stream;
    } on FirebaseException catch (er) {
      print("BirNima BOOOOOOOOOOOOOOOLdi");
      return stream;
    }



  }

  Stream<List<ChatRoomModel>> listenChat({required String docId}) {

    return _firestore.collection("chats")
        .doc(docId)
        .collection("chatRoom")
        .orderBy("datatime")
        .snapshots()
        .map((event) =>
        event
            .docs
            .map((e) => ChatRoomModel.fromJson(e.data())).toList());

  }
}

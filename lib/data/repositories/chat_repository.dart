import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_clone/data/models/chat_model.dart';



class ChatRepo {
  final FirebaseFirestore _firestore;

  ChatRepo({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addChat({required ChatModel chatModel}) async {
    try {
      DocumentReference newDocId =
      await _firestore.collection("chats").add(chatModel.toJson());
      await _firestore.collection("chats").doc(newDocId.id).update({
        "doc_id": newDocId.id,
      });

    } on FirebaseException catch (er) {
      // MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> deleteChat({required String docId}) async {
    try {
      await _firestore.collection("chats").doc(docId).delete();

      // MyUtils.getMyToast(message: "Mahsulot muvaffaqiyatli o'chirildi!");
    } on FirebaseException catch (er) {
      // MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Future<void> updateChat({required ChatModel chatModel}) async {
    try {
      await _firestore
          .collection("chats")
          .doc(chatModel.docId)
          .update(chatModel.toJson());

      // MyUtils.getMyToast(message: "Mahsulot muvaffaqiyatli yangilandi!");
    } on FirebaseException catch (er) {
      // MyUtils.getMyToast(message: er.message.toString());
    }
  }

  Stream<List<ChatModel>> getChats({required List users}) =>
      _firestore.collection("chats").where("two_user", isEqualTo: users).snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList(),
      );

  // Stream<List<ChatModel>> getProductsById({required String docId}) =>
  //     _firestore.collection("chats")
  //         .where("category_id", isEqualTo: docId)
  //         .snapshots()
  //         .map(
  //           (querySnapshot) => querySnapshot.docs
  //           .map((doc) => ChatModel.fromJson(doc.data()))
  //           .toList(),
  //     );

  Stream<List<ChatModel>> getChat({required String docId}) async* {
    if (docId.isEmpty) {
      yield* _firestore.collection("chats").snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList(),
      );
    } else {
      yield* _firestore
          .collection("chats")
          .where("doc_id", isEqualTo: docId)
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList(),
      );
    }
  }
}

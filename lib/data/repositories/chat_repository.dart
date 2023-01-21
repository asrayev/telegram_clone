import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:telegram_clone/data/models/chat_model.dart';


class ChatRepository {
  final FirebaseFirestore _firestore;
  ChatRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addChat({required ChatModel chatModel}) async {
    try {
      DocumentReference newChat =
      await _firestore.collection("chats").add(chatModel.toJson());
      await _firestore.collection("chats").doc(newChat.id).update({
        "doc_id": newChat.id,
      });

    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }
  // Future<bool> isProductExist(String productId) async {
  //   final QuerySnapshot result = await Firestore.instance
  //       .collection("products")
  //       .where("productId", isEqualTo: productId)
  //       .getDocuments();
  //   final List<DocumentSnapshot> documents = result.documents;
  //   return documents.length > 0;
  // }

//     Future<bool> checkChat({required List users}) async {
//       final  result = await _firestore.collection("chats").where("two_user", isEqualTo: users).snapshots().map((querySnapshot) => querySnapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
//           final List<ChatModel> documents = result;
//   }
// //   Future<String> getDocId({required List users}) async{
// //     var as = await _firestore.collection("chats").where("twoUser", isEqualTo: users).snapshots().map((querySnapshot) => querySnapshot.docs.map((doc) => ChatModel.fromJson(doc.data())).toList());
// //
// // }
//   import 'package:cloud_firestore/cloud_firestore.dart';
//
//   Future<List<Map<String, dynamic>>> getListsByProductId(String productId) async {
//     final QuerySnapshot result = await Firestore.instance
//         .collection("lists")
//         .where("productId", isEqualTo: productId)
//         .getDocuments();
//     final List<DocumentSnapshot> documents = result.documents;
//     return documents.map((doc) => doc.data).toList();
//   }
     Future<int> getEquals({required List users}) async {
     var result = await _firestore.collection("chats").where("two_user",isEqualTo: users)
         .snapshots().map(
             (querySnapshot) => querySnapshot.docs
             .map((doc) => ChatModel.fromJson(doc.data()))
             .toList());
        return result.length;
     }


  Future<void> deleteChat({required String docId}) async {
    try {
      await _firestore.collection("chats").doc(docId).delete();


    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }
  // _updateBookingPatientDetailsScreen(UpdateBookingPatientDetailsScreen event,
  //     Emitter<SingleAppointmentsState> emit) {
  //   AppointmentModel appointmentModel = state.appointmentModel.copyWith(
  //     age: event.age,
  //     fullName: event.fullName,
  //     gender: event.gender,
  //     phoneNumber: event.phoneNumber,
  //     problem: event.problem,
  //     createdAt: event.createdAd,
  //   );
  //   emit(state.copyWith(appointmentModel: appointmentModel));
  // }
  Future<void> updateChat({required ChatModel chatModel}) async {
    try {
      await _firestore
          .collection("chats")
          .doc(chatModel.docId)
          .update(chatModel.copyWith().toJson());


    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }
  Future<void> appendUpdateChat({required String docId, required Chat chat}) async {
    try {
      await _firestore
          .collection("chats")
          .doc(docId)
          .update({'chat': FieldValue.arrayUnion([chat])});


    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }
      // .doc('documentId')
      // .update({'listField': FieldValue.arrayUnion(['newElement'])});

  Stream<ChatModel> getChat(List currentUser) =>
      _firestore.collection("chats").where("twoUser", isEqualTo: currentUser,).snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList()[0],
      );



}

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firebaseFirestore})
      : _firestore = firebaseFirestore;

  Future<void> addUser({required UserModel userModel}) async {
    try {
      DocumentReference newUser =
      await _firestore.collection("users").add(userModel.toJson());
      await _firestore.collection("users").doc(newUser.id).update({
        "user_id": newUser.id,
      });

    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }

  Future<void> deleteUser({required String docId}) async {
    try {
      await _firestore.collection("users").doc(docId).delete();


    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }

  Future<void> updateUser({required UserModel userModel}) async {
    try {
      await _firestore
          .collection("users")
          .doc(userModel.userId)
          .update(userModel.toJson());


    } on FirebaseException catch (er) {
      print( er.message.toString());
    }
  }

  Stream<List<UserModel>> getAllUsers() =>
      _firestore.collection("users").snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList(),
      );


  Stream<List<UserModel>> getUser({required String userId}) async* {
    if (userId.isEmpty) {
      yield* _firestore.collection("users").snapshots().map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList(),
      );
    } else {
      yield* _firestore
          .collection("users")
          .where("categoryId", isEqualTo: userId)
          .snapshots()
          .map(
            (querySnapshot) => querySnapshot.docs
            .map((doc) => UserModel.fromJson(doc.data()))
            .toList(),
      );
    }
  }
}

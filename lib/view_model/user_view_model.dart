import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  UserViewModel({required this.userRepository}){
    listenUser("");
  }
  List<UserModel> userAdmin = [];
  late StreamSubscription subscription;

  List<UserModel> users = [];


  Stream<List<UserModel>> listenUsers1(String currentUser) =>
      userRepository.getAllUsers(currentUser);

  addUser(UserModel userModel) =>
      userRepository.addUser(userModel: userModel);

  updateUser(UserModel userModel) =>
      userRepository.updateUser(userModel: userModel);

  deleteUser(String docId) => userRepository.deleteUser(docId: docId);

  listenUser(String userId) async {
    subscription = userRepository
        .getUser(userId: userId)
        .listen((allUsers) {
      if(userId.isEmpty) userAdmin = allUsers;

      users = allUsers;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

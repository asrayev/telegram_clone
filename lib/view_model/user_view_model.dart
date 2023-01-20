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

  List<UserModel> products = [];

  // listenProducts() async {
  //   subscription = userRepository.getProducts().listen((allProducts) {
  //     products = allProducts;
  //     notifyListeners();
  //   })
  //     ..onError((er) {});
  // }
  Stream<List<UserModel>> listenUsers1() =>
      userRepository.getAllUsers();

  addUser(UserModel userModel) =>
      userRepository.addUser(userModel: userModel);

  updateUser(UserModel userModel) =>
      userRepository.updateUser(userModel: userModel);

  deleteUser(String docId) => userRepository.deleteUser(docId: docId);

  // listenProductsID(String categoryId) async {
  //   subscription = userRepository
  //       .getProductsById(categoryId: categoryId)
  //       .listen((allProducts) {
  //     print("ALL PRODUCTS LENGTH:${allProducts.length}");
  //     products = allProducts;
  //     notifyListeners();
  //   });
  // }
  listenUser(String userId) async {
    subscription = userRepository
        .getUser(userId: userId)
        .listen((allUsers) {
      if(userId.isEmpty) userAdmin = allUsers;
      print("ALL PRODUCTS LENGTH:${allUsers.length}");
      products = allUsers;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

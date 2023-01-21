import 'dart:async';
import 'package:flutter/material.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/repositories/chat_repository.dart';


class ChatViewModel extends ChangeNotifier {
  final ChatRepo chatRepo;

  ChatViewModel({required this.chatRepo}){
    listenChats("");
  }
  List<ChatModel> chatAdmin = [];
  late StreamSubscription subscription;

  List<ChatModel> chats = [];

  Stream<List<ChatModel>> listenAllChats1(List users) =>
      chatRepo.getChats(users: users);

  addChats(ChatModel chatModel) =>
      chatRepo.addChat(chatModel: chatModel);

  updateChats(ChatModel chatModel) =>
      chatRepo.updateChat(chatModel: chatModel);

  deleteChats(String docId) => chatRepo.deleteChat(docId: docId);


  listenChats(String docId) async {
    subscription = chatRepo
        .getChat(docId: docId)
        .listen((allProducts) {
      if(docId.isEmpty) chatAdmin = allProducts;
      print("ALL PRODUCTS LENGTH:${allProducts.length}");
      chats = allProducts;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

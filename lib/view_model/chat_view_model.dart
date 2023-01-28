import 'dart:async';
import 'package:flutter/material.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/repositories/chat_repository.dart';

import '../data/models/chat_room_model.dart';


class ChatViewModel extends ChangeNotifier {

  ChatViewModel({required this.chatRepo}){
    listenChats("AqxabSDybRZbBPyjx50uvo92YwP2_gqjdzKBEh7UauKx19KDgUrS1ct22");
    //listenAllChats1("AqxabSDybRZbBPyjx50uvo92YwP2_gqjdzKBEh7UauKx19KDgUrS1ct22");
  }
  List<ChatRoomModel> chatAdmin = [];
  late StreamSubscription subscription;

  final ChatRepo chatRepo;

  List<ChatRoomModel> chats = [];

  Stream<List<ChatRoomModel>>? listenAllChats1(String users) =>
      chatRepo.listenChat (docId: users);

  addChats(ChatModel chatModel, String newDoc) =>
      chatRepo.addChat(chatModel: chatModel, newDoc: newDoc);

  addMessage(ChatRoomModel chatRoomModel, String newDoc) =>
      chatRepo.addMessage(chatsId: newDoc, chatRoomModel: chatRoomModel);

  deleteChats(String docId) => chatRepo.deleteChat(docId: docId);

  listenChats(String docId){
    chatRepo.listenChat(docId: docId).listen((chatsList) {
      chats = chatsList;
      notifyListeners();
    });
  }

  // getChatDoc(String doc){
  //   return chatRepo.
  // }

  // listenChats(String docId) async {
  //   subscription = chatRepo
  //       .listenChat(docId: docId)
  //       .listen((allProducts) {
  //     if(docId.isEmpty) chatAdmin = allProducts;
  //     print("ALL PRODUCTS LENGTH:${allProducts.length}");
  //     chats = allProducts;
  //     notifyListeners();
  //   });
  // }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

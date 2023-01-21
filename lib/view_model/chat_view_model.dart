import 'dart:async';
import 'package:flutter/material.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/repositories/chat_repository.dart';
import '../data/models/user_model.dart';
import '../data/repositories/user_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository chatRepository;

  ChatViewModel({required this.chatRepository}){
    listenChat([]);
  }
  List<ChatModel> chatAdmin = [];
  late StreamSubscription subscription;

  List<ChatModel> users = [];


  Stream<ChatModel> listenChat(List currentUsers) =>
      chatRepository.getChat(currentUsers);

  addChat(ChatModel chatModel) =>
      chatRepository.addChat(chatModel: chatModel );
  checkUser(List users) =>
      chatRepository.getEquals(users: users);
  updateChat(ChatModel chatModel) =>
      chatRepository.updateChat(chatModel: chatModel);
  appendUpdate(String docId, Chat chat) =>
      chatRepository.appendUpdateChat(docId: docId, chat: chat);
  deleteChat(String docId) => chatRepository.deleteChat(docId: docId);



  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

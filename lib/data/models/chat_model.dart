
class ChatModel {
  final String docId;
  final List<Chat> chat;
  final List<String> twoUser;

  ChatModel({required this.docId, required this.chat, required this.twoUser});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    var list = json['chat'] as List;
    List<Chat> chatList = list.map((i) => Chat.fromJson(i)).toList();
    return ChatModel(
      docId: json['doc_id'],
      chat: chatList,
      twoUser: List<String>.from(json['two_user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doc_id': docId,
      'chat': chat.map((e) => e.toJson()).toList(),
      'two_user': twoUser,
    };
  }

  ChatModel copyWith({String? docId, List<Chat>? chat, List<String>? twoUser}) {
    return ChatModel(
        docId: docId ?? this.docId,
        chat: chat ?? this.chat,
        twoUser: twoUser ?? this.twoUser);
  }
}

class Chat {
  final String? userUid;
  final String? text;
  final String? dataTime;
  final String? forSome;

  Chat({this.userUid, this.text, this.dataTime, this.forSome});

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
        userUid: json['user_uid'],
        text: json['text'],
        dataTime: json['data_time'],
        forSome: json['for_some']);
  }

  Map<String, dynamic> toJson() {
    return {
      'user_uid': userUid,
      'text': text,
      'data_time': dataTime,
      'for_some': forSome,
    };
  }

  Chat copyWith(
      {String? userUid, String? text, String? dataTime, String? forSome}) {
    return Chat(
        userUid: userUid ?? this.userUid,
        text: text ?? this.text,
        dataTime: dataTime ?? this.dataTime,
        forSome: forSome ?? this.forSome);
  }
}
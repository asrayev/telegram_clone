import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram_clone/data/models/chat_room_model.dart';
import 'package:telegram_clone/ui/chat/widget/chat_get_widget.dart';
import 'package:telegram_clone/ui/chat/widget/chat_send_widget.dart';
import 'package:telegram_clone/utils/my_lotties.dart';
import 'package:telegram_clone/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';
import '../../utils/my_colors.dart';

class ChatPage extends StatefulWidget {
  final List twoUsers;
  final String chatName;
  final String imageUrl;
  final String currentUser;
  final String chatsDocId;

  const ChatPage(
      {Key? key,
      required this.twoUsers,
      required this.chatName,
      required this.imageUrl,
      required this.currentUser,
      required this.chatsDocId})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

final _textController = TextEditingController();

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.C_1B202D,
        appBar: AppBar(
          backgroundColor: MyColors.C_1B202D,
          title: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(widget.imageUrl),),
              SizedBox(width: 10.w,),
              Text(widget.chatName.toString()),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: StreamBuilder(
                    stream: Provider.of<ChatViewModel>(context, listen: false)
                        .listenAllChats1(widget.chatsDocId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.81,
                          width: MediaQuery.of(context).size.width,
                          color: MyColors.C_1B202D,
                          child: snapshot.data!.isEmpty
                              ?  Center(
                                  child: Lottie.asset(MyLottie.empty) ,
                                )
                              : ListView.builder(
                                  reverse: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var allData = snapshot.data!;
                                    index = index + 1;
                                    return allData[snapshot.data!.length - index].userUid != widget.currentUser
                                        ? ChatGetWidget(context: context, allData: allData, snapshot: snapshot, index: index)
                                        : ChatSendWidget(context: context, allData: allData, snapshot: snapshot, index: index);
                                  }),
                        );

                      }
                      if(snapshot.hasError){
                        return const CircularProgressIndicator();
                      }

                      else {
                        return Container();
                      }
                    }),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    color: MyColors.C_7A8194,
                    borderRadius: BorderRadius.circular(25).w),
                child: Padding(
                  padding: EdgeInsets.only(right: 15.r, left: 15.r),
                  child: Row(
                    children: [
                      MyInput(),
                      InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: (() {
                            if (_textController.text.trim() != "") {
                              Provider.of<ChatViewModel>(context, listen: false)
                                  .addMessage(
                                      ChatRoomModel(
                                          chatroomId: "",
                                          text: _textController.text,
                                          datatime: DateTime.now().toString(),
                                          userUid: widget.currentUser),
                                      getChatRoomId(widget.twoUsers[0],
                                          widget.twoUsers[1]));
                              _textController.clear();
                            }
                          }),
                          child: const Icon(Icons.send))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget MyInput() {
    return Expanded(
      child: TextField(
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0)),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(25).w,
            )),
      ),
    );
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/data/models/user_model.dart';
import 'package:telegram_clone/utils/my_colors.dart';
import 'package:telegram_clone/view_model/chat_view_model.dart';
import 'package:telegram_clone/view_model/user_view_model.dart';
import '../chat/chat_page.dart';

class HomeScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final currentUserUid;

  const HomeScreen({Key? key, required this.currentUserUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.black,
        body: SafeArea(
          child: StreamBuilder(
              stream: Provider.of<UserViewModel>(context, listen: false)
                  .listenUsers1(currentUserUid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return UsersWidget(
                          context,
                          data,
                          index,
                        );
                      });
                } else {
                  return Container();
                }
              }),
        ));
  }

  // ignore: non_constant_identifier_names
  Widget UsersWidget(BuildContext context, List<UserModel> data, int index) {
    return InkWell(
      onTap: (() async {
        // int uzun =  Provider.of<ChatViewModel>(context, listen: false).checkUser([currentUserUid, data[index].userUid]);
        if (2 == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                    chatName: data[index].name,imageUrl: data[index].imageUrl,
                        twoUsers: [currentUserUid, data[index].userUid],
                      )));
        } else {
          await Provider.of<ChatViewModel>(context, listen: false).addChat(
              ChatModel(
                  docId: "",
                  chat: [],
                  twoUser: [currentUserUid, data[index].userUid]));
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(chatName: data[index].name,imageUrl: data[index].imageUrl,

                      twoUsers: [currentUserUid, data[index].userUid])));
        }
      }),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 7).r,
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
              color: MyColors.C_161616,
              borderRadius: BorderRadius.circular(15).w),
          child: Padding(
            padding: const EdgeInsets.only(right: 80, left: 15).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(data[index].imageUrl),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data[index].name,
                      style: GoogleFonts.lalezar(
                          color: MyColors.white, fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

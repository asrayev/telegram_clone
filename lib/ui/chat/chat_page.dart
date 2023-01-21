import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:telegram_clone/data/models/chat_model.dart';
import 'package:telegram_clone/view_model/chat_view_model.dart';
import 'package:provider/provider.dart';
import '../../utils/my_colors.dart';

class ChatPage extends StatefulWidget {
  final List twoUsers;
  final String chatName;
  final String  imageUrl;
  const ChatPage({Key? key, required this.twoUsers, required this.chatName, required this.imageUrl}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}
final _textController = TextEditingController();
class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(title: Text(widget.chatName.toString()),),
    body: SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(height: MediaQuery.of(context).size.height*0.8,
           child: StreamBuilder(
                 stream: Provider.of<ChatViewModel>(context, listen: false).listenChat(widget.twoUsers),
                 builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        return ListView.builder(
                            itemCount: data!.chat.length,
                            itemBuilder: (context, index){
                          return Text(data.chat[index].text.toString());
                        });
                        }

                    else{
                      return Container();
                       }
                 }
             ),

          ),

          Container(
            height: MediaQuery.of(context).size.height*0.06,
            width: MediaQuery.of(context).size.width*0.95,
            decoration: BoxDecoration(
                color: MyColors.C_7A8194,
                borderRadius: BorderRadius.circular(25).w
            ),
            child: Padding(
              padding:  EdgeInsets.only(right: 15.r, left: 15.r),
              child: Row(
                children: [
                  _buildInput(),
                  InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: ((){




                      }),
                      child: const Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    )
    );
  }




  Widget _buildInput() {
    return Expanded(
      child: TextField(
        cursorColor: Colors.white,
        textCapitalization: TextCapitalization.sentences,
        style: const TextStyle(color: Colors.white),
        controller: _textController,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.white.withOpacity(0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
              BorderSide(color: Colors.white.withOpacity(0)),
            ),

            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(25).w,
            )
        ),
      ),
    );
  }
}





// {
//   "doc_id": "asdasd",
//   "chat": [
//     {"user_uid": "dasdasd",
//      "text": "asd",
//      "data_time": "asdas",
//      "for_some": "asd"
//
//     },
//     {"user_uid": "dasdasd",
//     "text": "asd",
//     "data_time": "asdas",
//     "for_some": "asd"
//     }
//   ],
//   "two_user": ["asdasd", "Sdadasd"]
//
// }
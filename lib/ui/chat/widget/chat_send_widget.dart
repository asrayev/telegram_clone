import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/models/chat_room_model.dart';
import '../../../utils/my_colors.dart';

class ChatSendWidget extends StatelessWidget {
 final  BuildContext context;
 final  List<ChatRoomModel> allData;
 final  AsyncSnapshot<List<ChatRoomModel>> snapshot;
 final  int index;

  const ChatSendWidget({Key? key, required this.context, required this.allData, required this.snapshot, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 3.r, bottom: 3.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding:  EdgeInsets.only(right: 10.r),
            child: InkWell(

              child: Container(
                padding:  EdgeInsets.only(right: 25.r, left: 15.r, top: 6.r, bottom: 6.r),
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width*0.6,
                    minWidth: MediaQuery.of(context).size.width*0.1
                ),
                decoration: BoxDecoration(
                    color: MyColors.C_7A8194,
                    borderRadius: BorderRadius.circular(20).w
                ),
                child:

                Text(allData[snapshot.data!.length-index].text,style: TextStyle(color: Colors.white,fontSize: 14.sp),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

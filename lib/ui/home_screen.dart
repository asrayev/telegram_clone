import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/utils/my_colors.dart';
import 'package:telegram_clone/view_model/user_view_model.dart';
class HomeScreen extends StatelessWidget {
  final currentUserUid;
  const HomeScreen({Key? key, required this.currentUserUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: MyColors.black,
      body: SafeArea(
        child: StreamBuilder(
          stream: Provider.of<UserViewModel>(context,listen: false).listenUsers1(currentUserUid),
    builder: (context, snapshot)
    {
        if (snapshot.hasData){
        var data = snapshot.data;
        return ListView.builder(
          itemCount: data!.length,
            itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
            child: Container(
              height: 80.h,
              decoration: BoxDecoration(
                color: MyColors.C_161616,
                borderRadius: BorderRadius.circular(15).w
              ),
              child: Row(
                children: [
                  Container(

                  )
                ],
              ),
            ),
          );
        });
    }
        else return Container();



    }),
      )
    );
  }
}

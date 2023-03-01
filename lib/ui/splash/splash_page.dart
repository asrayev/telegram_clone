import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram_clone/ui/auth/sign_up_page.dart';
import 'package:telegram_clone/ui/home/home_screen.dart';
import 'package:telegram_clone/utils/my_lotties.dart';
import '../../data/repositories/shared_repository.dart';
import '../../utils/my_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    onNextPage();
  }

  onNextPage() {
    // print(StorageRepository.getUserId());
    Future.delayed(const Duration(seconds: 3), () async {
      dynamic response = await StorageRepository.getUserId();
      response==""?
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignUpPage())) :

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen(currentUserUid: response)), (route) => false);

    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: MyColors.C_1B202D,
      body: Center(
        child: Lottie.asset(MyLottie.splash),
      )
    );
  }
}

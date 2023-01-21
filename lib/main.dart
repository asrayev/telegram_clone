import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:telegram_clone/ui/auth/sign_up_page.dart';
import 'package:telegram_clone/view_model/chat_view_model.dart';
import 'package:telegram_clone/view_model/user_view_model.dart';
import 'data/repositories/chat_repository.dart';
import 'data/repositories/user_repository.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fireStore = FirebaseFirestore.instance;
  runApp(

   MultiProvider(
       providers: [
         ChangeNotifierProvider(
           create: (context) => UserViewModel(
             userRepository: UserRepository(
               firebaseFirestore: fireStore,
             ),
           ),
         ),
         ChangeNotifierProvider(
           create: (context) => ChatViewModel(
             chatRepo: ChatRepo(
               firebaseFirestore: fireStore,
             ),
           ),
         ),


       ],
       child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(423.5294, 843.13727),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext contex, Widget? child) {
        return  const MaterialApp(
          debugShowCheckedModeBanner: false,
            home: SignUpPage()
        );
      },
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:telegram_clone/data/models/user_model.dart';
import 'package:telegram_clone/ui/auth/widget/my_textfield.dart';
import 'package:telegram_clone/ui/auth/widget/next_button.dart';
import 'package:telegram_clone/ui/home/home_screen.dart';
import '../../data/repositories/shared_repository.dart';
import '../../data/service/file_uploader.dart';
import '../../view_model/user_view_model.dart';
import 'package:provider/provider.dart';
class UserRegisterPage extends StatefulWidget {
  final String phoneNumber;
  const UserRegisterPage({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}
final ImagePicker _picker = ImagePicker();
XFile? _image;
String imageUrl = "";
bool isLoading = false;
final TextEditingController _controllerName = TextEditingController();

class _UserRegisterPageState extends State<UserRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration:  BoxDecoration(borderRadius: BorderRadius.circular(75),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                          imageUrl.isEmpty
                              ? const NetworkImage("https://picsum.photos/200")
                              : NetworkImage(
                            imageUrl,
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h,),
                Center(child: ElevatedButton(onPressed: (){_showPicker(context);}, child: const Text("Upload Image"))),
                SizedBox(height: 20.h,),
                MyTextField(controller: _controllerName, text: "Enter your name"),
                SizedBox(height: 380.h,),
                NextButton(isActive: checkActive(),onTap: ()  async {
                  var userId =  FirebaseAuth.instance.currentUser!.uid;
                  await  StorageRepository.saveUserId(userId);
                  // ignore: use_build_context_synchronously
                  if (checkActive()) {context.read<UserViewModel>().addUser(UserModel(
                      userId: "",
                      name: _controllerName.text,
                      imageUrl: imageUrl,
                      phoneNumber: widget.phoneNumber,
                      userUid: FirebaseAuth.instance.currentUser!.uid,
                      some: ""
                  ));

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(currentUserUid: FirebaseAuth.instance.currentUser!.uid,)));}
                  },)
              ],
            ),
          ),
        ),
    );
  }


  checkActive(){
    if(_controllerName.text.isNotEmpty && imageUrl.isNotEmpty){
      return true;
    }
    return false;
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    _getFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getFromGallery() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1000,
      maxHeight: 1000,
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      setState(() {
        isLoading = true;
      });
      imageUrl = await FileUploader.imageUploader(pickedFile);
      setState(() {
        isLoading = false;
        _image = pickedFile;
      });
    }
  }

  _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      maxWidth: 1920,
      maxHeight: 2000,
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if (!mounted) return;
      imageUrl = await FileUploader.imageUploader(pickedFile);
      setState(() {
        _image = pickedFile;
      });
    }
  }
}

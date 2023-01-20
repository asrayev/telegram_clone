import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.controller,
    required this.text,
    this.isDone = false,
  }) : super(key: key);



  final TextEditingController controller;
  final String text;
  bool? isDone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20).r,
      child: Material(
              borderRadius: BorderRadius.circular(30).w,
              shadowColor: Colors.blue.withOpacity(0.12),
              elevation: 25,
              child: TextFormField(
                textInputAction: isDone! ? TextInputAction.done : TextInputAction
                    .next,

                style: TextStyle( color: Colors.black, fontSize: 16.sp),
                obscureText: (text == "Password" || text == "Confirm Password"
                    ? true
                    : false),
                autovalidateMode: AutovalidateMode.onUserInteraction,

                controller: controller,
                keyboardType: TextInputType.name,
                decoration:
                InputDecoration(
                  hintText: text,
                  contentPadding: const EdgeInsets.only(left: 20),
                  hintStyle: TextStyle(
      color: Colors.grey, fontSize: 16),

                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide(color:  Colors.blue),
                  ),
                ),
                cursorColor: Colors.black,
              ),
            ),
    );


  }
}

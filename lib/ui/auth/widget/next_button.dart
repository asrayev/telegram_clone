import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required this.isActive,

    required this.onTap,

  }) : super(key: key);
  final bool isActive;

  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        width: double.infinity,
        height: 43.h,
        decoration: BoxDecoration(
          color: isActive ? null : Colors.blue.withOpacity(0.4),

          borderRadius: BorderRadius.circular(32),
        ),
        child: ElevatedButton(
          onPressed: isActive ? onTap : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            // shadowColor: Colors.transparent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
          child: Text(
            "Create account",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

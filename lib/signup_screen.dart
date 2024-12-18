import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/firebase/firebase_auth.dart';
import 'package:my_app/util/dialog.dart';
import 'package:my_app/util/exeption.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final passwordConfirm = TextEditingController();
  FocusNode passwordConfirm_F = FocusNode();

  @override
  void initState() {
    super.initState();
    // 각 FocusNode에 리스너 추가
    email_F.addListener(_onFocusChange);
    password_F.addListener(_onFocusChange);
    bio_F.addListener(_onFocusChange);
    username_F.addListener(_onFocusChange);
    passwordConfirm_F.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // 포커스 상태가 변경될 때마다 UI 갱신
    setState(() {});
  }

  @override
  void dispose() {
    // 사용 완료 후 해제
    email.dispose();
    password.dispose();
    bio.dispose();
    username.dispose();
    passwordConfirm.dispose();

    email_F.dispose();
    password_F.dispose();
    bio_F.dispose();
    username_F.dispose();
    passwordConfirm_F.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 96.w,
              height: 30.h,
            ),
            Center(
              child: Image.asset('images / logo.png'),
            ),
            SizedBox(
              height: 60.h,
            ),
            Center(
                child: CircleAvatar(
              radius: 32.r,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage('images/person.png'),
            )),
            SizedBox(
              height: 50.h,
            ),
            Textfield(email, Icons.email, 'Email', email_F),
            SizedBox(height: 15.h),
            Textfield(username, Icons.person, 'Username', username_F),
            SizedBox(height: 10.h),
            Textfield(bio, Icons.abc, 'bio', bio_F),
            SizedBox(height: 10.h),
            Textfield(password, Icons.lock, 'password', password_F),
            SizedBox(height: 10.h),
            Textfield(passwordConfirm, Icons.lock, 'passwordConfirm',
                passwordConfirm_F),
            SizedBox(height: 20.h),
            Signup(),
            SizedBox(height: 10.h),
            Have()
          ],
        ),
      ),
    );
  }

  Widget Have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "You have account?",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Signup() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          try {
            await Authentication().Signup(
              email: email.text,
              password: password.text,
              passwordConfirm: passwordConfirm.text,
              username: username.text,
              bio: bio.text,
              profile: File(''),
            );
          } on exeptions catch (e) {
            dialogBuilder(context, e.massage);
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Sign up',
            style: TextStyle(
              fontSize: 23.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget forgot() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        'Forgot your password?',
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget Textfield(TextEditingController controller, IconData icon, String type,
      FocusNode focusnode) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controller,
          focusNode: focusnode,
          decoration: InputDecoration(
            hintText: type,
            prefixIcon: Icon(
              icon,
              color: focusnode.hasFocus ? Colors.black : Colors.grey,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.grey, width: 2.w),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.black, width: 2.w),
            ),
          ),
        ),
      ),
    );
  }
}

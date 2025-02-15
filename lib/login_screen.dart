import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode(); // email용 포커스 노드
  final password = TextEditingController();
  FocusNode password_F = FocusNode(); // password용 포커스 노드

  @override
  void initState() {
    super.initState();
    // FocusNode의 포커스 상태 변화 감지를 위해 리스너 추가
    email_F.addListener(_onFocusChange);
    password_F.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // 포커스 상태가 변할 때마다 UI 갱신
    setState(() {});
  }

  @override
  void dispose() {
    // 사용한 controller와 focusnode 정리
    email.dispose();
    password.dispose();
    email_F.dispose();
    password_F.dispose();
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
              height: 100.h,
            ),
            Center(
              child: Image.asset('images / logo.png'),
            ),
            SizedBox(
              height: 120.h,
            ),
            // Textfield 호출 시 각 필드에 해당하는 FocusNode를 전달
            Textfield(email, Icons.email, 'Email', email_F),
            SizedBox(height: 15.h),
            Textfield(password, Icons.lock, 'Password', password_F),
            SizedBox(height: 10.h),
            forgot(),
            SizedBox(height: 10.h),
            Login(),
            SizedBox(height: 10.h),
            Have()
          ],
        ),
      ),
    );
  }

  Widget Have() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "No account yet?",
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Sign up",
              style: TextStyle(
                fontSize: 15.sp,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget Login() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          'Log in',
          style: TextStyle(
            fontSize: 23.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
          color: Colors.greenAccent,
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
              // 포커스 상태에 따라 아이콘 색상 변경 (focusnode.hasFocus)
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

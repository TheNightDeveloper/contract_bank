import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../widgets/auth_widgets.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        // physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox.shrink(),
              SvgPicture.asset(
                'assets/svg/Mobile login-cuate 1.svg',
                height: 240.h,
                width: 250.w,
              ),
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 50.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const MiddleBanner(),
                    SizedBox(
                      height: 10.h,
                    ),
                    AuthPageView(context: context)
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

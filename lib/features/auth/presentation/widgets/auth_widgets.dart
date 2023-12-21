import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vibration/vibration.dart';
import 'package:contract_bank/core/utils/const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:contract_bank/config/routes/names.dart';
import 'package:contract_bank/core/params/user_params.dart';
import 'package:contract_bank/features/article/presentation/provider/article_provider.dart';
import 'package:contract_bank/features/auth/presentation/provider/auth_provider.dart';

class AuthPageView extends StatefulWidget {
  final BuildContext context;
  const AuthPageView({super.key, required this.context});

  @override
  State<AuthPageView> createState() => _AuthPageViewState();
}

class _AuthPageViewState extends State<AuthPageView> {
  final PageController _pageController = PageController(initialPage: 2);

  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _registerPasswordController =
      TextEditingController();

  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _loginPhoneNumberController =
      TextEditingController();

  final TextEditingController _registerPhoneNumberController =
      TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _otpRegisterController = TextEditingController();

  final TextEditingController _otpNewPasswordController =
      TextEditingController();

  final _pinputTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: kSecondColor,
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(8),
    ),
  );

  double height = 270.h;

  bool timerEnd = false;

  final Curve curve = Curves.fastLinearToSlowEaseIn;

  @override
  Widget build(BuildContext context) {
    var articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        if (provider.isLoggedIn) {
          articleProvider.fetchData();
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.skeletonPage, (route) => false);
          });
        }
        return AnimatedContainer(
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          height: height,
          width: 320.w,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeIn,

          /// LOGIN / REGISTER SCREEN SWITCHER

          child: PageView(
            // scrollBehavior: MaterialScrollBehavior(),
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              ///  OTP SCREEN
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        'کد ارسالی را وارد کنید',
                        style: kMediumTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                        controller: _otpRegisterController,
                        length: 5,
                        defaultPinTheme: _pinputTheme),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                            fixedSize: Size(285.w, 42.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () async {
                          if (_otpRegisterController.text.length < 5) {
                            Vibration.vibrate(duration: 100);
                            Fluttertoast.showToast(
                                msg: 'کد را بصورت کامل وارد کنید');
                          } else {
                            await provider.eitherOrVerify([
                              _otpRegisterController.text,
                              _registerPhoneNumberController.text,
                              _registerPasswordController.text
                            ]);
                          }
                        },
                        child: provider.isLoading
                            ? const SpinKitThreeBounce(
                                color: kPrimaryColor,
                                size: 20,
                              )
                            : Text(
                                'تایید',
                                style: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor),
                              )),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          height = 320.h;
                        });
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: curve);
                      },
                      child: Text('اصلاح شماره تماس ',
                          style: kMediumTextStyle.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    !timerEnd
                        ? Countdown(
                            seconds: 120,
                            interval: const Duration(seconds: 1),
                            build: (_, time) => Text(time.toInt().toString(),
                                style: kMediumTextStyle),
                            onFinished: () {
                              setState(() {
                                timerEnd = true;
                              });
                            },
                          )
                        : InkWell(
                            onTap: () async {
                              await provider.eitherOrOtp(
                                  otpType: 'register',
                                  phoneNumber:
                                      _registerPhoneNumberController.text);
                              setState(() {
                                timerEnd = false;
                                // height = 320.h;
                              });
                              // _pageController.nextPage(
                              //     duration: const Duration(
                              //         milliseconds: 1000),
                              //     curve: curve);
                            },
                            child: Text('ارسال مجدد',
                                style: kMediumTextStyle.copyWith(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white)),
                          )
                  ],
                ),
              ),

              /// REGISTER SCREEN
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        child: Text(
                          'برای ثبت نام مشخصات خود را وارد کنید',
                          style: kMediumTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),

                      /// REGISTER FORM
                      Form(
                          child: Column(
                        children: [
                          _BuildTextField(
                            hint: 'نام خود را وارد کنید',
                            controller: _firstnameController,
                          ),
                          _BuildTextField(
                            hint: 'نام خانوادگی خود را وارد کنید',
                            controller: _lastnameController,
                          ),
                          BuildPasswordTextField(
                            hint: 'کلمه عبور خود را وارد کنید',
                            controller: _registerPasswordController,
                          ),
                          _PhoneNumberInput(
                              registerPhoneNumberController:
                                  _registerPhoneNumberController),
                        ],
                      )),

                      SizedBox(
                        height: 8.h,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kButtonColor,
                              fixedSize: Size(285.w, 42.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () async {
                            if (_firstnameController.text.isNotEmpty &&
                                _lastnameController.text.isNotEmpty &&
                                _registerPhoneNumberController
                                    .text.isNotEmpty &&
                                _registerPasswordController.text.isNotEmpty) {
                              var registerParam = RegisterParams(
                                firstname: _firstnameController.text.trim(),
                                lastname: _lastnameController.text.trim(),
                                phoneNumber:
                                    _registerPhoneNumberController.text,
                                password:
                                    _registerPasswordController.text.trim(),
                              );

                              var resault = await provider
                                  .eitherFailureOrRegister(registerParam);
                              if (resault) {
                                setState(() {
                                  height = 270.h;
                                });
                                _pageController.animateToPage(0,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: curve);
                              }
                            } else {
                              Vibration.vibrate(duration: 100);
                              Fluttertoast.showToast(
                                  msg:
                                      'مشخصات خود را بصورت کامل و صحیح وارد نمایید');
                            }
                          },
                          child: Text(
                            'تایید و ادامه',
                            style:
                                kMediumTextStyle.copyWith(color: kPrimaryColor),
                          )),
                      SizedBox(
                        height: 6.h,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            height = 270.h;
                          });
                          _pageController.animateToPage(2,
                              duration: const Duration(milliseconds: 1000),
                              curve: curve);
                        },
                        child: Text('قبلا ثبت نام کرده اید؟ وارد شوید',
                            style: kMediumTextStyle.copyWith(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),

              /// phone number SCREEN
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        'برای ورود شماره تماس خود را وارد کنید',
                        style: kMediumTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    _PhoneNumberInput(
                        registerPhoneNumberController:
                            _loginPhoneNumberController),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                            fixedSize: Size(285.w, 42.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if (_loginPhoneNumberController.text.length < 11) {
                            Vibration.vibrate(duration: 100);
                            Fluttertoast.showToast(
                                msg:
                                    'شماره تماس خود را بصورت صحیح وارد نمایید');
                          } else {
                            _pageController.nextPage(
                                duration: const Duration(milliseconds: 1500),
                                curve: curve);
                          }
                        },
                        child: Text(
                          'تایید و ادامه',
                          style:
                              kMediumTextStyle.copyWith(color: kPrimaryColor),
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          height = 330.h;
                        });
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 1000),
                            curve: curve);
                      },
                      child: Text('ثبت نام نکرده اید؟ ثبت نام کنید',
                          style: kMediumTextStyle.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)),
                    )
                  ],
                ),
              ),

              /// PASSWORD SCREEN
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        'کلمه عبور  خود را وارد کنید',
                        style: kMediumTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                        // margin: EdgeInsets.only(left: 10.w),
                        // padding: EdgeInsets.all(11.w),
                        decoration: BoxDecoration(
                            color: kSecondColor,
                            borderRadius: BorderRadius.circular(8)),
                        height: 42.h,
                        width: 280.w,
                        // alignment: Alignment.bottomCenter,
                        child: BuildPasswordTextField(
                          hint: 'کلمه عبور خود را وارد کنید',
                          controller: _loginPasswordController,
                        )),
                    SizedBox(
                      height: 15.h,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                            fixedSize: Size(285.w, 42.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () async {
                          if (_loginPasswordController.text.isNotEmpty) {
                            var loginParams = LoginParams(
                                _loginPhoneNumberController.text,
                                _loginPasswordController.text);

                            await provider.eitherFailureOrLogin(
                                loginParams, context);
                          } else {
                            Vibration.vibrate(duration: 100);
                            Fluttertoast.showToast(
                                msg: 'کلمه عبور خود را وارد نمایید');
                          }
                        },
                        child: provider.isLoading
                            ? const SpinKitThreeBounce(
                                color: kPrimaryColor,
                                size: 20,
                              )
                            : Text(
                                'تایید و ورود',
                                style: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor),
                              )),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        // setState(() {
                        //   height = 320.h;
                        // });
                        _pageController.previousPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: curve);
                      },
                      child: Text('اصلاح شماره تماس ',
                          style: kMediumTextStyle.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () async {
                        await provider.eitherOrOtp(
                            phoneNumber: _loginPhoneNumberController.text,
                            otpType: 'forget');
                        _pageController.animateToPage(4,
                            duration: const Duration(milliseconds: 1000),
                            curve: curve);
                      },
                      child: Text('فراموشی کلمه عبور',
                          style: kMediumTextStyle.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white)),
                    )
                  ],
                ),
              ),

              /// NEW PASSWORD
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Text(
                        'کد ارسالی را وارد کنید',
                        style: kMediumTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Pinput(
                        controller: _otpNewPasswordController,
                        length: 5,
                        defaultPinTheme: _pinputTheme),
                    SizedBox(
                      height: 10.h,
                    ),
                    BuildPasswordTextField(
                        hint: 'کلمه عبور جدید خود را وارد کنید',
                        controller: _newPasswordController),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kButtonColor,
                            fixedSize: Size(285.w, 42.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () async {
                          if (_newPasswordController.text.isNotEmpty ||
                              _otpNewPasswordController.text.length == 5) {
                            bool resault = await provider.eitherOrNewpassword(
                                phoneNumber: _loginPhoneNumberController.text,
                                code: _otpNewPasswordController.text,
                                newPassword: _newPasswordController.text);
                            if (resault) {
                              _pageController.animateToPage(2,
                                  duration: const Duration(milliseconds: 1000),
                                  curve: curve);
                            }
                          } else {
                            Vibration.vibrate(duration: 100);
                            Fluttertoast.showToast(
                                msg:
                                    'کد و رمز عبور جدید را بصورت صحیح وارد نمایید');
                          }
                        },
                        child: provider.isLoading
                            ? const SpinKitThreeBounce(
                                color: kPrimaryColor,
                                size: 20,
                              )
                            : Text(
                                'تایید',
                                style: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor),
                              )),
                    SizedBox(
                      height: 15.h,
                    ),
                    !timerEnd
                        ? Countdown(
                            seconds: 120,
                            interval: const Duration(seconds: 1),
                            build: (_, time) => Text(time.toInt().toString(),
                                style: kMediumTextStyle),
                            onFinished: () {
                              setState(() {
                                timerEnd = true;
                              });
                            },
                          )
                        : InkWell(
                            onTap: () async {
                              await provider.eitherOrOtp(
                                  otpType: 'forget',
                                  phoneNumber:
                                      _loginPhoneNumberController.text);
                              setState(() {
                                timerEnd = false;
                                // height = 320.h;
                              });
                              // _pageController.nextPage(
                              //     duration: const Duration(
                              //         milliseconds: 1000),
                              //     curve: curve);
                            },
                            child: Text('ارسال مجدد',
                                style: kMediumTextStyle.copyWith(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white)),
                          )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput({
    required TextEditingController registerPhoneNumberController,
  }) : _registerPhoneNumberController = registerPhoneNumberController;

  final TextEditingController _registerPhoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: kSecondColor, borderRadius: BorderRadius.circular(8)),
          height: 42.h,
          width: 45.w,
          alignment: Alignment.center,
          child: Text(
            '+98',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.sp),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 10.w),
            // padding: EdgeInsets.all(11.w),
            decoration: BoxDecoration(
                color: kSecondColor, borderRadius: BorderRadius.circular(8)),
            height: 42.h,
            width: 225.w,
            // alignment: Alignment.bottomCenter,
            child: TextFormField(
              controller: _registerPhoneNumberController,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) {},
              inputFormatters: [LengthLimitingTextInputFormatter(11)],
              textAlign: TextAlign.center,
              style: kMediumTextStyle.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp),
              keyboardType: TextInputType.number,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '09xxxxxxxxx',
                hintStyle: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp),
              ),
            )),
      ],
    );
  }
}

class _BuildTextField extends StatelessWidget {
  final String title, hint;
  final TextEditingController controller;
  const _BuildTextField(
      {this.title = '', required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 6.h),
        // padding: EdgeInsets.all(11.w),
        decoration: BoxDecoration(
            color: kSecondColor, borderRadius: BorderRadius.circular(8)),
        height: 42.h,
        width: 285.w,
        // alignment: Alignment.bottomCenter,
        child: TextField(
          controller: controller,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: kMediumTextStyle.copyWith(color: Colors.black87),
          keyboardType: TextInputType.text,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: kMediumTextStyle.copyWith(color: Colors.black26),
          ),
        ));
  }
}

class BuildPasswordTextField extends StatefulWidget {
  final String title, hint;
  final TextEditingController controller;
  const BuildPasswordTextField(
      {super.key,
      this.title = '',
      required this.hint,
      required this.controller});

  @override
  State<BuildPasswordTextField> createState() => _BuildPasswordTextField();
}

class _BuildPasswordTextField extends State<BuildPasswordTextField> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 6.h),
        // padding: EdgeInsets.all(11.w),
        decoration: BoxDecoration(
            color: kSecondColor, borderRadius: BorderRadius.circular(8)),
        height: 42.h,
        width: 285.w,
        // alignment: Alignment.bottomCenter,
        child: TextField(
          obscureText: visibility,
          controller: widget.controller,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: kMediumTextStyle.copyWith(color: Colors.black87),
          keyboardType: TextInputType.visiblePassword,
          cursorColor: kPrimaryColor,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            border: InputBorder.none,
            hintText: widget.hint,
            hintStyle: kMediumTextStyle.copyWith(color: Colors.black26),
            prefixIcon: InkWell(
              onTap: () {
                setState(() {
                  visibility = !visibility;
                });
              },
              child: Icon(
                visibility ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
            // prefixIconColor: Colors.grey,
          ),
        ));
  }
}

class MiddleBanner extends StatelessWidget {
  const MiddleBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerRight, children: [
      Container(
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          height: 50.h,
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'مخزن قرارداد ها',
                    style: kMediumTextStyle.copyWith(color: Colors.white),
                    textDirection: TextDirection.rtl,
                  ),
                  Text('رایگان | جامع | در دسترس',
                      style: kMediumTextStyle.copyWith(
                          color: Colors.white.withOpacity(.6))),
                ],
              ),
              const SizedBox.shrink()
            ],
          )),
      Container(
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 2,
                spreadRadius: 2,
              )
            ],
            image: const DecorationImage(
                image: AssetImage('assets/img/logo.png'), fit: BoxFit.cover)),
        height: 70.h,
        width: 70.w,
      )
    ]);
  }
}

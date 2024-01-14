import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/contract_bank_icons.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> confirmLogout(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Dialog(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 25,
                      child: Icon(
                        Icons.logout,
                        color: kPrimaryColor,
                        size: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("خروج از حساب کاربری",
                        style: kMediumTextStyle.copyWith(
                            fontSize: 22.sp, color: Colors.black87)),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Text("مطمئنید که می خواهید از حساب کاربری خارج شوید؟",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style:
                            kMediumTextStyle.copyWith(color: Colors.black54)),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              prefs.clear();
                              Provider.of<AuthProvider>(context, listen: false)
                                  .logOut();
                              Fluttertoast.showToast(
                                  msg: 'از حساب کاربری خارج شدید');
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    AppRoutes.loginPage, (route) => false);
                              });
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            child: Text(
                              'خروج',
                              style: kMediumTextStyle,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: kPrimaryColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16))),
                            child: Text(
                              'بازگشت',
                              style: kMediumTextStyle.copyWith(
                                  color: kPrimaryColor),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const BuildAppbar(),
        const BuildImage(imageName: 'Sent Message-bro'),
        const BuildMiddleBanner(text: 'ارتباط با ما'),
        SliverToBoxAdapter(
          child: Column(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _launchUrl(Uri.parse('https://www.instagram.com/pazhcc'));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: kGreenBoxDecoration,
                  height: 50.h,
                  width: 320.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'اینستاگرام مرکز قراردادهای پاژ',
                            style: kMediumTextStyle,
                          ),
                          Text(
                            '@pazhcc',
                            style: kMediumTextStyle.copyWith(fontSize: 11.sp),
                          )
                        ],
                      ),
                      SizedBox(width: 5.w),
                      const Icon(
                        ContractBankIcons.instagram_3,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl(Uri.parse('https://www.pazhcc.com/'));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: kGreenBoxDecoration,
                  height: 50.h,
                  width: 320.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'وبسایت مرکز قراردادهای پاژ',
                            style: kMediumTextStyle,
                          ),
                          Text(
                            'www.pazhcc.com',
                            style: kMediumTextStyle.copyWith(fontSize: 11.sp),
                          )
                        ],
                      ),
                      SizedBox(width: 5.w),
                      const Icon(
                        ContractBankIcons.global_3,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchUrl(Uri.parse('tel:09154742515'));
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 7.h),
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: kGreenBoxDecoration,
                  height: 50.h,
                  width: 320.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تماس با مرکز قراردادهای پاژ',
                            style: kMediumTextStyle,
                          ),
                          Text(
                            '09154742515',
                            style: kMediumTextStyle.copyWith(fontSize: 11.sp),
                          )
                        ],
                      ),
                      SizedBox(width: 5.w),
                      const Icon(
                        ContractBankIcons.call_3,
                        color: Colors.white,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchUrl(Uri.parse(
                              'bazaar://details?id=com.pazhcc.contractsbank'))
                          .catchError((onError) {
                        Fluttertoast.showToast(
                            msg: 'از نصب بودن کافه بازار مطمئن شوید!');
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      decoration: kGreenBoxDecoration,
                      height: 45.h,
                      width: 152.w,
                      child: Text(
                        'ثبت نظر و امتیاز در بازار',
                        style: kMediumTextStyle.copyWith(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      confirmLogout(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      decoration: kGreenBoxDecoration,
                      height: 45.h,
                      width: 152.w,
                      child: Text(
                        'خروج از حساب کاربری',
                        style: kMediumTextStyle.copyWith(fontSize: 14.sp),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

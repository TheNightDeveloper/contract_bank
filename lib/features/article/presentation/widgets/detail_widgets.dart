import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contracts_bank/core/utils/const.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/services/adivery_service.dart';
import '../../../../core/utils/contract_bank_icons.dart';

class BuildDetailAppbar extends StatelessWidget {
  final String title;
  const BuildDetailAppbar({
    super.key,
    required this.title,
  });
  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  Future<void> donationDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
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
                    Image.asset(
                      'assets/img/icons8-donate-64.png',
                      height: 40.h,
                      width: 40.w,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("حمایت از تیم توسعه اپلیکیشن",
                        style: kMediumTextStyle.copyWith(
                            fontSize: 20.sp, color: Colors.black87)),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Text(
                        "در صورت رضایت از اپلیکیشن میتوانید با دیدن تبلیغات  و سپس با ثبت 5 امتیاز  از تیم توسعه اپلیکیشن حمایت کنید و مارا برای تولید محتوای جدید دلگرم کنید",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style:
                            kMediumTextStyle.copyWith(color: Colors.black54)),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          InterstitialAds.showInterstitial(onClose: (close) {
                            _launchUrl(Uri.parse(
                                    'bazaar://details?id=com.pazhcc.contractsbank'))
                                .catchError((onError) {
                              Fluttertoast.showToast(
                                  msg:
                                      'جهت ثبت رای و نظر خود از نصب بودن کافه بازار مطمئن شوید!');
                            });
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Text(
                          'حمایت',
                          style: kMediumTextStyle,
                        ))
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0.h),
      sliver: SliverAppBar(
        // forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(top: 1.h),
          background: Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: Container(
                padding: EdgeInsets.only(left: 8.w, right: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              donationDialog(context);
                            },
                            icon: Image.asset(
                              'assets/img/icons8-donate-64(1).png',
                              height: 19.h,
                              width: 20.w,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () async {
                              // showModalBottomSheet(
                              //     useSafeArea: true,
                              //     context: context,
                              //     builder: (_) => const RatingBarBottomSheet());
                              await Share.share(
                                  'https://cafebazaar.ir/app/com.pazhcc.contractsbank',
                                  subject:
                                      'جامع ترین و کامل ترین اپلیکیشن مخزن نمونه قراردادهای کاربردی');
                            },
                            icon: const Icon(
                              Icons.share_rounded,
                              color: Colors.white,
                            )),
                      ],
                    ),

                    // SizedBox(
                    //   width: 100.w,
                    // ),
                    Text(
                      'مخزن قرارداد ها',
                      textAlign: TextAlign.right,
                      style: kMediumTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          collapseMode: CollapseMode.pin,
          expandedTitleScale: 1,
          centerTitle: true,
          title: SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10.w),
                  alignment: Alignment.centerRight,
                  decoration: kGreyBoxDecoration,
                  height: 40.h,
                  width: 273.w,
                  child: Text(
                    title,
                    style: kMediumTextStyle.copyWith(color: kPrimaryColor),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: kGreyBoxDecoration,
                    height: 40.h,
                    width: 43.w,
                    child: const Icon(
                      ContractBankIcons.back_icon,
                      color: kPrimaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        pinned: true,
        expandedHeight: 95.h,
      ),
    );
  }
}

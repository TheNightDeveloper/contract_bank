import 'package:contracts_bank/config/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/detail_widgets.dart';

class DevsTeamPage extends StatelessWidget {
  DevsTeamPage({super.key});

  final List imageList = [
    'assets/img/pazhcc-logo-01 2.png',
    'assets/img/icons8-backend-64.png',
    'assets/img/icons8-front-end-64.png',
    'assets/img/icons8-ux-64.png',
    'assets/img/icons8-content-64.png',
  ];
  final List textList = [
    'صاحب امتیاز',
    'توسعه دهنده بک اند',
    'توسعه دهنده فرانت اند',
    'طراح رابط کاربری و بصری',
    'محتوا گزاری و پشتیبانی سایت',
  ];
  final List subList = [
    'مرکز قرارداد های پاژ (موسسه حقوقی داوری بین المللی فرشته خرداندیش عدالت پاژ)',
    'مجید موحدی نسب',
    'محمد صادق امیری',
    'مهرداد گرافیگ (م.ب تمسکنی )',
    'آژانس تبلیغاتی بوف\n'
        'یگانه عطاری',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              const BuildDetailAppbar(
                title: 'آشنایی با تیم توسعه دهنده',
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    if (index.isEven) {
                      return Container(
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(-3, 4),
                                color: kBackGroundColor,
                                blurRadius: 4,
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(colors: [
                              kBackGroundColor,
                              Colors.white,
                            ])),
                        child: ListTile(
                          horizontalTitleGap: 25.w,
                          minVerticalPadding: 8,
                          // dense: true,
                          subtitleTextStyle: kMediumTextStyle.copyWith(
                              color: Colors.black38, fontSize: 13.5.sp),
                          titleTextStyle:
                              kMediumTextStyle.copyWith(color: Colors.black87),
                          trailing: Image.asset(imageList[index]),
                          title: Text(
                            textList[index],
                            textDirection: TextDirection.ltr,
                          ),
                          subtitle: Text(
                            subList[index],
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(3, 4),
                                color: kBackGroundColor,
                                blurRadius: 4,
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                            gradient: const LinearGradient(
                                colors: [Colors.white, kBackGroundColor])),
                        child: ListTile(
                          subtitleTextStyle: kMediumTextStyle.copyWith(
                              color: Colors.black38, fontSize: 13.5.sp),
                          titleTextStyle:
                              kMediumTextStyle.copyWith(color: Colors.black87),
                          leading: Image.asset(
                            imageList[index],
                          ),
                          title: Text(
                            textList[index],
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                          subtitle: Text(
                            subList[index],
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                      );
                    }
                  },
                  itemCount: 5,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                ),
              )
              // SliverToBoxAdapter(
              //     child: Container(
              //   padding: EdgeInsets.symmetric(horizontal: 15.w),
              //   child
              // ))
            ],
          ),
        ));
  }
}

/*
ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    if (index.isEven) {
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          trailing: SizedBox.expand(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage(imageList[index]))),
                            ),
                          ),
                          title: Text(textList[index]),
                          subtitle: Text(subList[index]),
                        ),
                      );
                    } else {
                      return ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(imageList[index]))),
                        ),
                        title: Text(
                          textList[index],
                          textAlign: TextAlign.right,
                        ),
                        subtitle:
                            Text(subList[index], textAlign: TextAlign.right),
                      );
                    }
                  },
                ),*/

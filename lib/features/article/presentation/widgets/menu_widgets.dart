import 'package:contracts_bank/features/article/presentation/pages/subpage/devs_team_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/utils/contract_bank_icons.dart';

import '../../../../core/utils/menu_content.dart';
import '../pages/subpage/content_page.dart';

class BuildMenu extends StatelessWidget {
  const BuildMenu({super.key});
  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.w, vertical: 3.h),
                        width: 155.w,
                        height: 85.h,
                        decoration: kGreyBoxDecoration,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ContentPage(content: MenuContent.first)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/img/${MenuContent.first['icon']}',
                                scale: 1.8.r,
                                color: kPrimaryColor,
                              ),
                              Text(
                                MenuContent.first['title'],
                                style: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 3.h),
                      width: 155.w,
                      height: 35.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage(content: MenuContent.third)));
                        },
                        child: Text(MenuContent.third['title'],
                            style: kMediumTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 0.w, vertical: 3.h),
                        width: 155.w,
                        height: 85.h,
                        decoration: kGreyBoxDecoration,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ContentPage(content: MenuContent.fifth)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                'assets/img/${MenuContent.fifth['icon']}',
                                scale: 1.8.r,
                                color: kPrimaryColor,
                              ),
                              Text(MenuContent.fifth['title'],
                                  style: kMediumTextStyle.copyWith(
                                      color: kPrimaryColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        )),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 3.h),
                      width: 155.w,
                      height: 35.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage(content: MenuContent.seventh)));
                        },
                        child: Text(MenuContent.seventh['title'],
                            style: kMediumTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(
                      width: 155.w,
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                _launchUrl(
                                    Uri.parse('https://www.pazhcc.com/'));
                              },
                              style: IconButton.styleFrom(
                                  backgroundColor: kBackGroundColor,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.grey, width: .7),
                                      borderRadius: BorderRadius.circular(16))),
                              icon: const Icon(
                                ContractBankIcons.global_3,
                                color: kPrimaryColor,
                              )),
                          IconButton(
                              onPressed: () {
                                _launchUrl(
                                    Uri.parse('https://instagram.com/pazhcc'));
                              },
                              style: IconButton.styleFrom(
                                  backgroundColor: kBackGroundColor,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.grey, width: .7),
                                      borderRadius: BorderRadius.circular(16))),
                              icon: const Icon(ContractBankIcons.instagram_3,
                                  color: kPrimaryColor)),
                          IconButton(
                              onPressed: () {
                                _launchUrl(Uri.parse('tel:09154742515'));
                              },
                              style: IconButton.styleFrom(
                                  backgroundColor: kBackGroundColor,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.grey, width: .7),
                                      borderRadius: BorderRadius.circular(16))),
                              icon: const Icon(ContractBankIcons.call_3,
                                  color: kPrimaryColor)),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 3.h),
                      width: 155.w,
                      height: 35.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage(content: MenuContent.second)));
                        },
                        child: Text(MenuContent.second['title'],
                            style: kMediumTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.w, vertical: 3.h),
                      width: 155.w,
                      height: 35.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage(content: MenuContent.fourth)));
                        },
                        child: Text(MenuContent.fourth['title'],
                            style: kMediumTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 3.h),
                      width: 155.w,
                      height: 35.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Fluttertoast.showToast(
                              msg:
                                  'در دست توسعه می باشد، بزودی منتشر خواهد شد');
                        },
                        child: Text(MenuContent.sixth['title'],
                            style: kMediumTextStyle.copyWith(
                                color: kPrimaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 3.h),
                      width: 155.w,
                      height: 85.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage(content: MenuContent.eighth)));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/img/${MenuContent.eighth['icon']}',
                              scale: 1.8.r,
                              color: kPrimaryColor,
                            ),
                            Text(MenuContent.eighth['title'],
                                style: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 3.h),
                      width: 155.w,
                      height: 85.h,
                      decoration: kGreyBoxDecoration,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ContentPage(content: MenuContent.tenth)));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/img/${MenuContent.tenth['icon']}',
                              scale: 1.8.r,
                              color: kPrimaryColor,
                            ),
                            Text(MenuContent.tenth['title'],
                                style: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 35.h,
              width: 330.w,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: kGreyBoxDecoration,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DevsTeamPage()));
                },
                child: Text(
                  MenuContent.devTeam['title'],
                  // textScaler: const TextScaler.linear(1.1),
                  style: kMediumTextStyle.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

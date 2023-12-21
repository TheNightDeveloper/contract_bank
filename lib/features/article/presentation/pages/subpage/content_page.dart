import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/const.dart';
import '../../widgets/detail_widgets.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key, required this.content});
  final Map<String, dynamic> content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        // alignment: Alignment.topCenter,
        color: Colors.white,
        height: 55.h,
        width: double.infinity,
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(16)),
          child: Text(
            'www.PAZHCC.com',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            BuildDetailAppbar(
              title: content['mainTitle'],
            ),
            SliverToBoxAdapter(
                child: Container(
              padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 60.h),
              child: Column(
                children: [
                  Text(
                    content['content'],
                    style: kMediumTextStyle.copyWith(color: Colors.black87),
                    softWrap: true,
                    textDirection: TextDirection.rtl,
                  ),
                  content['title'] == 'درباره مرکز'
                      ? Image.asset(
                          'assets/img/pazhcc-logo-01 2.png',
                          // height: 80.h,
                          // width: 85.h,
                        )
                      : const SizedBox.shrink()
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

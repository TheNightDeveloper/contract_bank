import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:contract_bank/core/utils/const.dart';
import 'package:contract_bank/core/utils/contract_bank_icons.dart';

class BuildDetailAppbar extends StatelessWidget {
  final String title;
  const BuildDetailAppbar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: SliverAppBar(
        // forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(top: 1.h),
          background: Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(16)),
                child: Text(
                  'مخزن قرارداد ها',
                  style: kMediumTextStyle.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
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
                  ),
                ),
                Container(
                  decoration: kGreyBoxDecoration,
                  height: 40.h,
                  width: 43.w,
                  child: const Icon(
                    ContractBankIcons.back_icon,
                    color: kPrimaryColor,
                    size: 28,
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

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contract_bank/core/utils/const.dart';
import 'package:contract_bank/core/utils/contract_bank_icons.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    // Provider.of<ArticleProvider>(context,listen: false).getArticle();
    return CustomScrollView(
      slivers: [
        const BuildAppbar(),
        const BuildCarouselSlider(),
        SliverToBoxAdapter(
          child: Center(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            decoration: kGreenBoxDecoration,
            height: 35.h,
            width: 220.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'دسته بندی قرارداد ها',
                  style: kMediumTextStyle.copyWith(color: Colors.white),
                ),
                const Icon(
                  ContractBankIcons.sidebar_bottom_1,
                  color: Colors.white,
                )
              ],
            ),
          )),
        ),
        const CategoryList()
      ],
    );
  }
}

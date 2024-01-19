import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:contracts_bank/features/article/presentation/pages/subpage/detail_page.dart';
import '../../../../core/utils/const.dart';
import '../provider/article_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BuildSearchBox extends StatelessWidget {
  BuildSearchBox({
    super.key,
  });

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/svg/Job hunt-pana 1.svg',
          height: 110.h,
          width: 320.w,
        ),

        /// BLUR EFFECT
        ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                height: 110.h,
                width: 320.w,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.25),
                    border: Border.all(color: Colors.grey, width: .7),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ':عنوان مورد نظر خود را جستجو کنید',
                      style: kMediumTextStyle.copyWith(
                          color: Colors.green,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          shadows: [
                            const Shadow(
                                // bottomLeft
                                offset: Offset(0, 3),
                                blurRadius: 8,
                                color: Colors.black54),
                          ]),
                    ),
                    TextField(
                        keyboardType: TextInputType.text,
                        autofocus: true,
                        controller: _controller,
                        onChanged: (key) async {
                          await Provider.of<ArticleProvider>(context,
                                  listen: false)
                              .search(key);
                        },
                        textDirection: TextDirection.rtl,
                        style: kMediumTextStyle.copyWith(color: Colors.black54),
                        cursorColor: kPrimaryColor,
                        decoration: InputDecoration(
                          // isCollapsed: true,
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          hintText: 'جستجو عنوان...',
                          hintTextDirection: TextDirection.rtl,
                          prefixIcon: Container(
                            margin: EdgeInsets.only(left: 2.w),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(.7),
                        ))
                  ],
                ),
              )),
        ),
      ],
    ));
  }
}

class BuildSearchList extends StatelessWidget {
  const BuildSearchList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: const SpinKitThreeBounce(
              color: kPrimaryColor,
              size: 35,
              duration: Duration(milliseconds: 1000),
            ),
          ),
        );
      } else if (provider.searchList!.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
              alignment: Alignment.center,
              // color: Colors.blue[100],
              child: Text(
                'قرارداد یافت نشد   ',
                style: kLargeTextStyle.copyWith(color: Colors.grey),
              )),
        );
      } else {
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          sliver: SliverList.builder(
            itemCount: provider.searchList!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    tileColor: kBackGroundColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailPage(
                                article: provider.searchList![index],
                              )));
                    },
                    titleTextStyle:
                        kMediumTextStyle.copyWith(color: kPrimaryColor),
                    title: Text(
                      provider.searchList![index].title,
                      textAlign: TextAlign.right,
                    ),
                    leading: const Icon(
                      Icons.article,
                      color: kPrimaryColor,
                    ),
                  ));
            },
            // separatorBuilder: (BuildContext context, int index) => Divider(
            //   height: 10.h,
            //   indent: 15.w,
            //   endIndent: 15.w,
            //   thickness: 1,
            //   color: Colors.grey,
            // ),
          ),
        );
      }
    });
  }
}

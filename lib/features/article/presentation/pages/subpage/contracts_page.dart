import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:contract_bank/core/widgets/common_widgets.dart';

import '../../widgets/category_widgets.dart';

class ContractsPage extends StatelessWidget {
  // final List<ArticleEntity>? articleList;

  const ContractsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final imageName = args['imageName'];
    final categoryTitle = args['categoryName'];
    final categoryId = args['id'];
    return Scaffold(
        backgroundColor: Colors.white,
        // bottomNavigationBar: BottomCategoryNavBar(context: context),
        body: SafeArea(
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              const BuildAppbar(),
              SliverToBoxAdapter(
                child: SvgPicture.asset(
                  imageName,
                  height: 140.h,
                  width: 145.w,
                ),
              ),
              BuildMiddleBanner(text: 'نمونه قراردادهای $categoryTitle'),
              BuildLawList(
                categoryId: categoryId,
              )
            ],
          ),
        ));
  }
}

/*SliverPadding(
                padding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                sliver: SliverList.separated(
                  itemCount: articleList.isNotEmpty ? articleList.length : 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: articleList.isNotEmpty
                            ? ListTile(
                                onTap: () {
                                  // Navigator.pushNamed(context, ArticleViewScreen.routeName , arguments: ArticleModel(articleList[index]));
                                  showBottomSheet(
                                    constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height*.97),
                                    enableDrag: false,
                                    context: context,
                                    builder: (_) => DetailPage(
                                        article: articleList[index]),
                                  );
                                },
                                titleTextStyle: kMediumTextStyle.copyWith(
                                    color: kPrimaryColor),
                                title: Text(
                                  articleList[index].title,
                                  textAlign: TextAlign.right,
                                ),
                                leading: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      ContractBankIcons.bookmark_icon_1,
                                      color: kPrimaryColor,
                                    )),
                              )
                            : SizedBox.square(
                                dimension: 40.h,
                                child: Text(
                                  '!نمونه قراردادی وجود ندارد',
                                  style: kMediumTextStyle.copyWith(
                                      color: kPrimaryColor),
                                  textAlign: TextAlign.center,
                                ),
                              ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 10.h,
                    indent: 15.w,
                    endIndent: 15.w,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
              )*/

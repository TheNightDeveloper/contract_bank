import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibration/vibration.dart';
import 'package:contracts_bank/features/article/presentation/pages/subpage/detail_page.dart';
import 'package:contracts_bank/features/article/presentation/provider/article_provider.dart';

import '../../../../config/routes/routes.dart';

class BuildBookmarkList extends StatelessWidget {
  const BuildBookmarkList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, provider, child) {
      if (provider.bookmarkArticle!.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
              alignment: Alignment.center,
              // color: Colors.blue[100],
              child: Text(
                'قرارداد نشان شده ای ندارید',
                style: kLargeTextStyle.copyWith(color: Colors.grey),
              )),
        );
      } else {
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          sliver: SliverList.separated(
            itemCount: provider.bookmarkArticle!.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  article: provider.bookmarkArticle![index])));
                    },
                    titleTextStyle:
                        kMediumTextStyle.copyWith(color: kPrimaryColor),
                    title: Text(
                      provider.bookmarkArticle![index].title,
                      textAlign: TextAlign.right,
                    ),
                    leading: IconButton(
                        onPressed: () async {
                          Vibration.vibrate(duration: 100);
                          var id =
                              provider.bookmarkArticle![index].id.toString();
                          await provider.deleteBookmark(id);
                        },
                        icon: const Icon(
                          Icons.bookmark,
                          color: kPrimaryColor,
                        )),
                  ));
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 10.h,
              indent: 15.w,
              endIndent: 15.w,
              thickness: 1,
              color: Colors.grey,
            ),
          ),
        );
      }
    });
  }
}

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vibration/vibration.dart';
import '../../../../config/routes/routes.dart';
import '../../domain/entities/article_entity.dart';
import '../pages/subpage/detail_page.dart';
import '../provider/article_provider.dart';

class BuildContractList extends StatelessWidget {
  final int categoryId;
  const BuildContractList({super.key, required this.categoryId});
  bool isBookmark(ArticleEntity articleEntity, BuildContext context) {
    return Provider.of<ArticleProvider>(context, listen: false)
        .bookmarkArticle!
        .contains(articleEntity);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(builder: (context, provider, child) {
      final List<ArticleEntity> articleList = provider.allArticle!
          .where((article) => article.category['id'] == categoryId)
          .toList();
      if (articleList.isEmpty) {
        return SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
              alignment: Alignment.center,
              // color: Colors.blue[100],
              child: Text(
                'نمونه قراردادی وجود ندارد ',
                style: kLargeTextStyle.copyWith(color: Colors.grey),
              )),
        );
      } else {
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
          sliver: SliverList.separated(
            itemCount: articleList.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    tileColor: kBackGroundColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              DetailPage(article: articleList[index])));
                    },
                    titleTextStyle:
                        kMediumTextStyle.copyWith(color: kPrimaryColor),
                    title: Text(
                      articleList[index].title,
                      textAlign: TextAlign.right,
                    ),
                    leading: IconButton(
                        onPressed: () async {
                          Vibration.vibrate(duration: 80);

                          /// CHECK WHETHER IS ARTICLE BOOKMARKED
                          bool articleIsBookmark =
                              isBookmark(articleList[index], context);
                          if (articleIsBookmark) {
                            var id = articleList[index].id.toString();
                            await provider.deleteBookmark(id);
                          } else {
                            await provider.postBookmark(articleList[index].id);
                          }
                        },
                        icon: Icon(
                          provider.bookmarkArticle!.contains(articleList[index])
                              ? Icons.bookmark
                              : Icons.bookmark_outline,
                          // ContractBankIcons.global_3,
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

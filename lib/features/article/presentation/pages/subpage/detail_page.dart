import 'package:contracts_bank/core/services/adivery_service.dart';
import 'package:contracts_bank/features/article/presentation/provider/article_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/widgets/common_widgets.dart';
import 'package:contracts_bank/features/article/domain/entities/article_entity.dart';
import 'package:contracts_bank/features/article/presentation/widgets/detail_widgets.dart';

class DetailPage extends StatelessWidget {
  final ArticleEntity? article;
  const DetailPage({super.key, this.article});

  Future<void> saveToClipBoard(String content) async {
    await Clipboard.setData(ClipboardData(text: content));
    Fluttertoast.showToast(msg: 'قرار داد کپی شد');
  }

  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Fluttertoast.showToast(msg: 'لینگ فعال نمیباشد');
      throw 'could not launch $url';
    }
  }

  bool isBookmark(ArticleEntity articleEntity, BuildContext context) {
    return Provider.of<ArticleProvider>(context, listen: false)
        .bookmarkArticle!
        .contains(articleEntity);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ArticleProvider>(context);
    final List<Widget> fabIcons = [
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: kBackGroundColor.withOpacity(.6)),
          icon: const Icon(
            Icons.copy,
            color: kPrimaryColor,
          ),
          onPressed: () async {
            if (provider.copied == 0) {
              await saveToClipBoard(article!.content);
              print(provider.copied);
              provider.copy(1);
            } else {
              print(provider.copied);
              InterstitialAds.showInterstitial(onClose: (close) async {
                await saveToClipBoard(article!.content);
                provider.copy(0);
              });
              provider.copy(0);
            }
          }),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: kBackGroundColor.withOpacity(.6)),
          icon: !provider.bookmarkArticle!.contains(article)
              ? const Icon(
                  Icons.bookmark_add_outlined,
                  color: kPrimaryColor,
                )
              : const Icon(
                  Icons.bookmark,
                  color: kPrimaryColor,
                ),
          onPressed: () async {
            bool articleIsBookmark = isBookmark(article!, context);
            if (articleIsBookmark) {
              var id = article!.id.toString();
              await provider.deleteBookmark(id);
            } else {
              await provider.postBookmark(article!.id);
            }
          }),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: kBackGroundColor.withOpacity(.6)),
          icon: const Icon(
            Icons.link,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Uri url = Uri.parse(article!.url);
            _launchUrl(url)
                .whenComplete(() => InterstitialAds.showInterstitial());

            // InterstitialAds.showInterstitial();
          }),
    ];
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ExpandableFab(distance: 80.r, children: fabIcons),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: Size(double.infinity, 10.h),
            child: SizedBox(
              height: 10.h,
            )),
        body: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.transparent,
                Colors.transparent,
                Colors.white
              ],
              stops: [0, 0.0, .95, 1],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstOut,
          child: CustomScrollView(
            slivers: [
              BuildDetailAppbar(
                title: article!.main_title,
              ),
              SliverToBoxAdapter(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Text(
                  article!.content,
                  style: kMediumTextStyle.copyWith(color: Colors.black87),
                  softWrap: true,
                  textDirection: TextDirection.rtl,
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contract_bank/config/routes/routes.dart';
import 'package:contract_bank/core/widgets/common_widgets.dart';
import 'package:contract_bank/features/article/domain/entities/article_entity.dart';
import 'package:contract_bank/features/article/presentation/widgets/detail_widgets.dart';

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
      throw 'could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> fabIcons = [
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: kBackGroundColor.withOpacity(.6)),
          icon: const Icon(
            Icons.copy,
            color: kPrimaryColor,
          ),
          onPressed: () async {
            await saveToClipBoard(article!.content);
          }),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: kBackGroundColor.withOpacity(.6)),
          icon: const Icon(
            Icons.bookmark_add_outlined,
            color: kPrimaryColor,
          ),
          onPressed: () {}),
      IconButton(
          style: IconButton.styleFrom(
              backgroundColor: kBackGroundColor.withOpacity(.6)),
          icon: const Icon(
            Icons.link,
            color: kPrimaryColor,
          ),
          onPressed: () {
            Uri url = Uri.parse(article!.url);
            _launchUrl(url).catchError((onError) {
              Fluttertoast.showToast(msg: "لینک مقاله فعال نمی باشد");
            });
          }),
    ];
    return Scaffold(
        floatingActionButton: ExpandableFab(distance: 80.r, children: fabIcons),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.white
                ],
                stops: [0.0, 0.0, .95, 1],
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
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
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
        ));
  }
}

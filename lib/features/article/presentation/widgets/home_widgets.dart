import 'package:carousel_slider/carousel_slider.dart';
import 'package:contracts_bank/core/utils/category_enum.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:contracts_bank/config/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/article_provider.dart';

class _BuildCategoryGrid extends StatelessWidget {
  final BuildContext context;
  const _BuildCategoryGrid({
    required this.context,
  });

  final categorys = Categorys.values;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 11.w, mainAxisSpacing: 11.h),
        delegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.contractsPage,
                        arguments: categorys[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .7),
                        color: kBackGroundColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          categorys[index].imagePath,
                          height: 100.h,
                          width: 100.w,
                        ),
                        Text(
                          categorys[index].title,
                          // textList[index],
                          softWrap: true,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          style:
                              kMediumTextStyle.copyWith(color: kPrimaryColor),
                        )
                      ],
                    ),
                  ),
                ),
            childCount: 9),
      ),
    );
  }
}

class BuildCarouselSlider extends StatelessWidget {
  const BuildCarouselSlider({
    super.key,
  });
  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: CarouselSlider(
          items: [
            GestureDetector(
              onTap: () {
                _launchUrl(Uri.parse('https://pazhcc.com'));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: 350.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/img/Slider-01-PazhApp-min.jpg'),
                      fit: BoxFit.fill),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                // child: const Text('slider1'),
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchUrl(Uri.parse('https://pazhcc.com/regulation'));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: 350.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/img/Slider-02-PazhApp-min.jpg'),
                      fit: BoxFit.fill),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                // child: const Text('slider1'),
              ),
            ),
            GestureDetector(
              onTap: () {
                _launchUrl(Uri.parse('https://instagram.com/pazhcc'));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: 350.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/img/Slider-03-PazhApp-min.jpg'),
                      fit: BoxFit.fill),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                // child: const Text('slider1'),
              ),
            )
          ],
          options: CarouselOptions(
            height: 185.h,
            enlargeCenterPage: true,
            enlargeFactor: 0.22,
            // autoPlay: true
          ),
        ),
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleProvider>(
      builder: (context, provider, child) {
        if (provider.allArticle!.isNotEmpty) {
          return _BuildCategoryGrid(
            context: context,
          );
        } else if (provider.exception != null) {
          return SliverToBoxAdapter(
              child:
                  Center(child: Text('Error:${provider.exception!.message}')));
        } else {
          // provider.fetchData();
          return const SliverToBoxAdapter(
              child: Center(
                  child: SpinKitThreeBounce(
            color: kPrimaryColor,
          )));
        }
      },
    );
  }
}

/* imageList.map((image) => Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 350.w,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image)),
                boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 5))
              ], borderRadius: BorderRadius.circular(16), ),
              // child: const Text('slider1'),
            ),).toList() */

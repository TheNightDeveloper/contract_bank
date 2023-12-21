import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:contract_bank/config/routes/routes.dart';
import '../provider/article_provider.dart';

class _BuildCategoryGrid extends StatelessWidget {
  final BuildContext context;
  _BuildCategoryGrid({
    required this.context,
  });

  final List imageList = [
    'assets/svg/Building permit-bro 1.svg',
    'assets/svg/ISO Certification-bro(1) 1.svg',
    'assets/svg/Business deal-bro 1.svg',
    'assets/svg/Signing a contract-bro 1.svg',
    'assets/svg/Documents-bro 1.svg',
    'assets/svg/Car finance-bro 1.svg',
    'assets/svg/Car finance-bro 1.svg',
    'assets/svg/Car finance-bro 1.svg',
    'assets/svg/Car finance-bro 1.svg',
  ];
  final List textList = [
    'ساخت و ساز ',
    'مشارکت و سرمایه گذاری',
    'استخدام و منابع انسانی',
    'محافظت از کسب و کار',
    'پیمانکاری کسب و کار',
    ' خرید و فروش',
    'مالکیت',
    'اجاره',
    'سایر قرارداد ها',
  ];

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15.w, mainAxisSpacing: 10.h),
        delegate: SliverChildBuilderDelegate(
            (context, index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.contractsPage,
                        arguments: {
                          'categoryName': textList[index],
                          'imageName': imageList[index],
                          'id': index + 1
                        });
                    // Provider.of<SkeletProvider>(context, listen: false)
                    //     .changePage('page6');
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
                          imageList[index],
                          height: 100.h,
                          width: 100.w,
                        ),
                        Text(
                          textList[index],
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

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: CarouselSlider(
          items: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 350.w,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 5))
              ], borderRadius: BorderRadius.circular(16), color: Colors.red),
              child: const Text('slider1'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 350.w,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 5))
                  ],
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.blueAccent),
              child: const Text('slider2'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              width: 350.w,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 5))
              ], borderRadius: BorderRadius.circular(16), color: Colors.pink),
              child: const Text('slider3'),
            ),
          ],
          options: CarouselOptions(
              height: 185.h, enlargeCenterPage: true, enlargeFactor: 0.22),
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

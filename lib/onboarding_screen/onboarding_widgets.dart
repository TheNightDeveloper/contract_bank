import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:contracts_bank/config/routes/routes.dart';

class PageViewBuilder extends StatelessWidget {
  final String title, subtitle, imageName;
  const PageViewBuilder({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox.shrink(),
        SizedBox(
          child: SvgPicture.asset(
            'assets/svg/$imageName.svg',
            height: 220.h,
            width: 220.w,
          ),
        ),
        Column(
          children: [
            Text(
              title,
              style: kMediumTextStyle.copyWith(
                  color: kPrimaryColor, fontSize: 20.sp),
            ),
            Text(
              subtitle,
              style: kMediumTextStyle.copyWith(
                  color: kPrimaryColor.withOpacity(.6)),
            )
          ],
        )
      ],
    );
  }
}

class BuildDotsIndicator extends StatelessWidget {
  final BuildContext context;
  const BuildDotsIndicator(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
        reversed: true,
        position: Provider.of<OnboardingProvider>(context).index,
        mainAxisAlignment: MainAxisAlignment.center,
        dotsCount: 2,
        decorator: DotsDecorator(
          spacing: EdgeInsets.symmetric(horizontal: 3.w),
          color: kPrimaryColor.withOpacity(.5),
          size: const Size.square(10),
          activeColor: kPrimaryColor,
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          activeSize: const Size(18, 9),
        ));
  }
}

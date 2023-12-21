import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/routes/routes.dart';
import 'onboarding_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              PageView(
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  onPageChanged: (page) {
                    if (page == 0) {
                      Provider.of<OnboardingProvider>(context, listen: false)
                          .changeText('< بعدی');
                    } else {
                      Provider.of<OnboardingProvider>(context, listen: false)
                          .changeText('ورود');
                    }
                    Provider.of<OnboardingProvider>(context, listen: false)
                        .changePage(page);
                  },
                  children: const [
                    PageViewBuilder(
                      title: 'کامل و جامع',
                      subtitle: 'نگران قرارداد هایت نباش',
                      imageName: 'Personal files-bro 1',
                    ),
                    PageViewBuilder(
                        title: 'همیشه در دسترس',
                        subtitle: 'نگران قرارداد هایت نباش',
                        imageName: 'Attached files-bro 1'),
                  ]),
              Positioned(
                  bottom: 25.h,
                  left: 15.w,
                  child: TextButton(
                    onPressed: () {
                      var index = Provider.of<OnboardingProvider>(context,
                              listen: false)
                          .index;
                      if (index < 1) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.fastEaseInToSlowEaseOut);
                      } else {
                        // prefs.setBool(storageDeviceOpenFirstTime, false);
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      }
                    },
                    child: Text(
                      Provider.of<OnboardingProvider>(context).buttonText,
                      style: kMediumTextStyle.copyWith(color: kPrimaryColor),
                    ),
                  )),
              Positioned(bottom: 40.h, child: BuildDotsIndicator(context))
            ],
          ),
        ),
      ),
    );
  }
}

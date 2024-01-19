import 'package:adivery/adivery.dart';
import 'package:contracts_bank/config/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:contracts_bank/features/article/presentation/widgets/skelet_widgets.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  State<SkeletonScreen> createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  bool canPop = false;
  @override
  void initState() {
    super.initState();
    AdiveryPlugin.prepareInterstitialAd(adsPlacementID);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SkeletProvider>(context);

    return PopScope(
      canPop: canPop,
      onPopInvoked: (pop) {
        if (provider.page != 2) {
          provider.changeScreen(2);
        } else {
          Fluttertoast.showToast(msg: 'press back again to exit');
          setState(() {
            canPop = true;
          });
        }
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavBar(
            context: context,
          ),
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
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.white
                  ],
                  stops: [0.0, 0.0, .97, 1],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstOut,
              child: Screens(index: provider.page)),
        ),
      ),
    );
  }
}
/* Scaffold(
        // bottomNavigationBar: BottomNavBar(
        //   context: context,
        // ),
        body: SafeArea(
          child: Stack(alignment: Alignment.topCenter, children: [
            ShaderMask(
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
                    stops: [0.0, 0.10, 0.90, 1.0],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstOut,
                child: Screens(index: page)),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomNavBar(
                  context: context,
                ))
          ]),
        ),
      ),*/

/* PersistentTabView(
          context,
          controller: _controller,
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          screens: buildScreens(),
          items: navBarsItems(),
          confineInSafeArea: true,
          navBarHeight: 50.h,
          backgroundColor: kPrimaryColor, // Default is Colors.white.
          handleAndroidBackButtonPress: true, // Default is true.
          resizeToAvoidBottomInset:
              true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          stateManagement: true, // Default is true.
          hideNavigationBarWhenKeyboardShows:
              true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(16),
            colorBehindNavBar: Colors.white,
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            // Navigation Bar's items animation properties.
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle
              .style15, // Choose the nav bar style with this property.
        )*/

/*Scaffold(
        bottomNavigationBar: BottomNavBar(
          context: context,
          onSelect: (int index) {
            provider.changeScreen(index);
            provider.changePage(pagesKey[index]);
          },
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Offstage(
              offstage: provider.currentPage != 'page2',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page2'], page: 'page2'),
            ),
            Offstage(
              offstage: provider.currentPage != 'page3',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page3'], page: 'page3'),
            ),
            Offstage(
              offstage: provider.currentPage != 'page4',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page4'], page: 'page4'),
            ),
            Offstage(
              offstage: provider.currentPage != 'page5',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page5'], page: 'page5'),
            ),
            Offstage(
              offstage: provider.currentPage != 'page1',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page1'], page: 'page1'),
            ),
            Offstage(
              offstage: provider.currentPage != 'page6',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page6'], page: 'page6'),
            ),
            Offstage(
              offstage: provider.currentPage != 'page7',
              child: TabNavigator(
                  navigatorKey: navigatorKey['page7'], page: 'page7'),
            ),
          ],
        )),
      ),*/

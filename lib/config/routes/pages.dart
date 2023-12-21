import 'package:contract_bank/config/routes/routes.dart';

import '../../features/article/presentation/pages/home_page.dart';
import '../../features/article/presentation/pages/subpage/contracts_page.dart';
import '../../features/article/presentation/provider/article_provider.dart';

class AppPages {
  // return page entities
  static List<PageEntity> pages() {
    return [
      PageEntity(
          route: AppRoutes.initial,
          page: const SplashScreen(),
          provider: ChangeNotifierProvider(
            create: (_) => sl<ArticleProvider>(),
            lazy: true,
          )),
      PageEntity(
          route: AppRoutes.onBoarding,
          page: OnboardingScreen(),
          provider: ChangeNotifierProvider(
            create: (_) => OnboardingProvider(),
            lazy: true,
          )),
      PageEntity(
          route: AppRoutes.loginPage,
          page: const AuthPage(),
          provider: ChangeNotifierProvider(
            create: (_) => sl<AuthProvider>(),
            lazy: true,
          )),
      PageEntity(
          route: AppRoutes.skeletonPage,
          page: const SkeletonScreen(),
          provider: ChangeNotifierProvider(
            create: (_) => SkeletProvider(),
            lazy: true,
          )),
      PageEntity(
          route: AppRoutes.homePage,
          page: HomePage(),
          provider: ChangeNotifierProvider(
            create: (_) => sl<ArticleProvider>(),
            // lazy: true,
          )),
      PageEntity(
          route: AppRoutes.contractsPage,
          page: ContractsPage(),
          provider: ChangeNotifierProvider(
            create: (context) => sl<ArticleProvider>(),
            // lazy: true,
          )),
      // PageEntity(
      //     route: AppRoutes.detailPage,
      //     page: const DetailPage(),
      //     provider: ChangeNotifierProvider(
      //       create: (context) => sl<ArticleProvider>(),
      //       lazy: true,
      //     )),
      // PageEntity(
      //     route: AppRoutes.bookmarkPage,
      //     page: const BookmarkPage(),
      //     provider: ChangeNotifierProvider(
      //       create: (context) => sl<ArticleProvider>(),
      //       lazy: true,
      //     )),
      // PageEntity(
      //     route: AppRoutes.searchPage,
      //     page: SearchPage(),
      //     provider: ChangeNotifierProvider(
      //       create: (context) => sl<ArticleProvider>(),
      //       lazy: true,
      //     )),
    ];
  }

  // return all bloc providers
  static List allProviders(BuildContext context) {
    List providers = [];
    for (var provider in pages()) {
      if (!providers.contains(provider.provider)) {
        providers.add(provider.provider);
      }
    }
    // print(providers);
    return providers;
  }

  // return routes models for pages
  static MaterialPageRoute generateRoutes(RouteSettings settings) {
    // check  routes name matching when Navigator called
    if (settings.name != null) {
      var result = pages().where((element) => element.route == settings.name!);
      if (result.isNotEmpty) {
        // check application open for first time
        // bool appFirstOpen = prefs.getBool(storageDeviceIsLoggedIn);
        // if (result.first.route == AppRoutes.onBoarding && !appFirstOpen) {
        //   return MaterialPageRoute(
        //       builder: (_) => const AuthPage(), settings: settings);
        // }
        return MaterialPageRoute(
          builder: (_) => result.first.page as Widget,
          settings: settings,
        );
      }
    }
    print('invalid routes ${settings.name}');
    return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}

// unifying Bloc , pages and routes
class PageEntity {
  String? route;
  Widget? page;
  dynamic provider;
  PageEntity({this.route, this.page, this.provider});
}

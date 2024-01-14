import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:contracts_bank/features/article/presentation/pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:contracts_bank/core/utils/const.dart';
import '../../../../core/utils/contract_bank_icons.dart';
import 'package:contracts_bank/features/article/presentation/pages/bookmark_page.dart';
import 'package:contracts_bank/features/article/presentation/pages/home_page.dart';
import 'package:contracts_bank/features/article/presentation/provider/skeleton_provider.dart';
import '../pages/menu_page.dart';
import '../pages/search_page.dart';

class Screens extends StatelessWidget {
  final int index;
  const Screens({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      const ContactPage(),
      const BookmarkPage(),
      const HomePage(),
      const SearchPage(),
      const MenuPage(),
    ];
    return screens[index];
  }
}

// List<PersistentBottomNavBarItem> navBarsItems() {
//   return [
//     PersistentBottomNavBarItem(
//       iconSize: 30,
//       icon: const Icon(
//         ContractBankIcons.contact_icon,
//         color: Colors.white,
//       ),
//       activeColorPrimary: Colors.red,
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 30,
//       icon: const Icon(ContractBankIcons.bookmark_icon, color: Colors.white),
//       activeColorPrimary: Colors.red,
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 30,
//       icon: const Icon(ContractBankIcons.home_icon, color: Colors.white),
//       // activeColorPrimary: kButtonColor,
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 30,
//       icon: const Icon(ContractBankIcons.search_icon, color: Colors.white),
//       activeColorPrimary: Colors.red,
//     ),
//     PersistentBottomNavBarItem(
//       iconSize: 30,
//       icon: const Icon(ContractBankIcons.category_icon, color: Colors.white),
//       activeColorPrimary: Colors.red,
//     ),
//   ];
// }

class BottomNavBar extends StatelessWidget {
  final BuildContext context;

  BottomNavBar({super.key, required this.context});

  final List<Widget> activeIcon = [
    const Icon(ContractBankIcons.contact_icon, color: Colors.white, size: 34),
    const Icon(
      ContractBankIcons.bookmark_icon,
      color: Colors.white,
      size: 34,
    ),
    const Icon(ContractBankIcons.home_icon, color: Colors.white, size: 34),
    const Icon(ContractBankIcons.search_icon, color: Colors.white, size: 34),
    const Icon(ContractBankIcons.category_icon, color: Colors.white, size: 34),
  ];

  final List<Widget> inactiveIcon = [
    const Icon(
      ContractBankIcons.contact_icon,
      color: Colors.white,
    ),
    const Icon(ContractBankIcons.bookmark_icon, color: Colors.white),
    const Icon(ContractBankIcons.home_icon, color: Colors.white),
    const Icon(ContractBankIcons.search_icon, color: Colors.white),
    const Icon(ContractBankIcons.category_icon, color: Colors.white),
  ];

  /// CONTACT US DIALOG
  // Future<dynamic> contactUsDialog(BuildContext context) {
  //   return showDialog(
  //       barrierColor: Colors.white54,
  //       context: context,
  //       builder: (_) {
  //         return BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
  //           child: Padding(
  //             padding: EdgeInsets.only(bottom: 70.h),
  //             child: Column(
  //               textDirection: TextDirection.rtl,
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Container(
  //                   alignment: Alignment.center,
  //                   margin: EdgeInsets.symmetric(vertical: 7.h),
  //                   padding: EdgeInsets.symmetric(horizontal: 12.w),
  //                   decoration: kGreenBoxDecoration,
  //                   height: 50.h,
  //                   width: 320.w,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             'اینستاگرام مرکز قراردادهای پاژ',
  //                             style: kMediumTextStyle,
  //                           ),
  //                           Text(
  //                             '@pazhcc',
  //                             style: kMediumTextStyle.copyWith(fontSize: 11.sp),
  //                           )
  //                         ],
  //                       ),
  //                       SizedBox(width: 5.w),
  //                       IconButton(
  //                         onPressed: () {
  //                           launchUrl(
  //                               Uri.parse('https://www.instagram.com/pazhcc'));
  //                         },
  //                         icon: const Icon(
  //                           ContractBankIcons.instagram_3,
  //                           color: Colors.white,
  //                           size: 40,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   margin: EdgeInsets.symmetric(vertical: 7.h),
  //                   padding: EdgeInsets.symmetric(horizontal: 12.w),
  //                   decoration: kGreenBoxDecoration,
  //                   height: 50.h,
  //                   width: 320.w,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             'وبسایت مرکز قراردادهای پاژ',
  //                             style: kMediumTextStyle,
  //                           ),
  //                           Text(
  //                             'www.pazhcc.com',
  //                             style: kMediumTextStyle.copyWith(fontSize: 11.sp),
  //                           )
  //                         ],
  //                       ),
  //                       SizedBox(width: 5.w),
  //                       IconButton(
  //                         onPressed: () {
  //                           launchUrl(Uri.parse('https://www.pazhcc.com/'));
  //                         },
  //                         icon: const Icon(
  //                           ContractBankIcons.global_3,
  //                           color: Colors.white,
  //                           size: 40,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   alignment: Alignment.center,
  //                   margin: EdgeInsets.symmetric(vertical: 7.h),
  //                   padding: EdgeInsets.symmetric(horizontal: 12.w),
  //                   decoration: kGreenBoxDecoration,
  //                   height: 50.h,
  //                   width: 320.w,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Column(
  //                         crossAxisAlignment: CrossAxisAlignment.end,
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           Text(
  //                             'تماس با مرکز قراردادهای پاژ',
  //                             style: kMediumTextStyle,
  //                           ),
  //                           Text(
  //                             '09154742515',
  //                             style: kMediumTextStyle.copyWith(fontSize: 11.sp),
  //                           )
  //                         ],
  //                       ),
  //                       SizedBox(width: 5.w),
  //                       IconButton(
  //                         onPressed: () {
  //                           launchUrl(Uri.parse('tel:09154742515'));
  //                         },
  //                         icon: const Icon(
  //                           ContractBankIcons.call_3,
  //                           color: Colors.white,
  //                           size: 40,
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Container(
  //                       alignment: Alignment.center,
  //                       margin: EdgeInsets.symmetric(vertical: 7.h),
  //                       decoration: kGreenBoxDecoration,
  //                       height: 45.h,
  //                       width: 152.w,
  //                       child: Text(
  //                         'ثبت نظر و امتیاز در بازار',
  //                         style: kMediumTextStyle.copyWith(fontSize: 14.sp),
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () {
  //                         confirmLogout();
  //                       },
  //                       child: Container(
  //                         alignment: Alignment.center,
  //                         margin: EdgeInsets.symmetric(vertical: 7.h),
  //                         decoration: kGreenBoxDecoration,
  //                         height: 45.h,
  //                         width: 152.w,
  //                         child: Text(
  //                           'خروج از حساب کاربری',
  //                           style: kMediumTextStyle.copyWith(fontSize: 14.sp),
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SkeletProvider>(context);
    return CircleNavBar(
        onTap: (index) {
          // if (index != 0) {
          /// selected index
          provider.changeScreen(index);
          // } else {
          //   Future.delayed(Duration.zero, () {
          //     contactUsDialog(context);
          //   });
          // }
        },
        cornerRadius: BorderRadius.circular(16),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        activeIndex: provider.page,

        /// selected index
        circleGradient: const RadialGradient(
          radius: 1.8,
          stops: [0.35, 0.9],
          center: Alignment.bottomCenter,
          colors: [
            kButtonColor,
            kPrimaryColor,
          ],
        ),
        activeIcons: activeIcon,
        elevation: 5,
        circleShadowColor: Colors.grey,
        inactiveIcons: inactiveIcon,
        height: 50.h,
        circleWidth: 43.w,
        color: kPrimaryColor);
  }

//   Future<void> confirmLogout() {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (_) => Dialog(
//               elevation: 1,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15)),
//               child: Container(
//                 width: MediaQuery.of(context).size.width / 1.4,
//                 height: MediaQuery.of(context).size.height / 3,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(15.0),
//                     boxShadow: [
//                       BoxShadow(
//                           offset: const Offset(12, 26),
//                           blurRadius: 50,
//                           spreadRadius: 0,
//                           color: Colors.grey.withOpacity(.1)),
//                     ]),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircleAvatar(
//                       backgroundColor: Colors.white,
//                       radius: 25,
//                       child: Icon(
//                         Icons.logout,
//                         color: kPrimaryColor,
//                         size: 50,
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Text("خروج از حساب کاربری",
//                         style: kMediumTextStyle.copyWith(
//                             fontSize: 22.sp, color: Colors.black87)),
//                     const SizedBox(
//                       height: 3.5,
//                     ),
//                     Text("مطمئنید که می خواهید از حساب کاربری خارج شوید؟",
//                         textAlign: TextAlign.center,
//                         textDirection: TextDirection.rtl,
//                         style:
//                             kMediumTextStyle.copyWith(color: Colors.black54)),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         ElevatedButton(
//                             onPressed: () {
//                               prefs.clear();
//                               Provider.of<AuthProvider>(context, listen: false)
//                                   .logOut();
//                               Fluttertoast.showToast(
//                                   msg: 'از حساب کاربری خارج شدید');
//                               Future.delayed(const Duration(seconds: 1), () {
//                                 Navigator.pushNamedAndRemoveUntil(context,
//                                     AppRoutes.loginPage, (route) => false);
//                               });
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: kPrimaryColor,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16))),
//                             child: Text(
//                               'خروج',
//                               style: kMediumTextStyle,
//                             )),
//                         ElevatedButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 side: const BorderSide(color: kPrimaryColor),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16))),
//                             child: Text(
//                               'بازگشت',
//                               style: kMediumTextStyle.copyWith(
//                                   color: kPrimaryColor),
//                             )),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ));
//   }
// }
/*CircleNavBar(
        onTap: (index) {
          if (index != 0) {
            /// selected index
            provider.changeScreen(index);
          } else {
            Future.delayed(Duration.zero, () {
              contactUsDialog(context);
            });
          }
        },
        cornerRadius: BorderRadius.circular(16),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        activeIndex: provider.page,

        /// selected index
        circleGradient: const RadialGradient(
          radius: 1.8,
          stops: [0.35, 0.9],
          center: Alignment.bottomCenter,
          colors: [
            kButtonColor,
            kPrimaryColor,
          ],
        ),
        activeIcons: activeIcon,
        elevation: 5,
        circleShadowColor: Colors.grey,
        inactiveIcons: inactiveIcon,
        height: 50.h,
        circleWidth: 43.w,
        color: kPrimaryColor);*/
}

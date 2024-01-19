import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/services/adivery_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class BuildAppbar extends StatelessWidget {
  const BuildAppbar({
    super.key,
  });

  Future<void> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  Future<void> donationDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => Dialog(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(12, 26),
                          blurRadius: 50,
                          spreadRadius: 0,
                          color: Colors.grey.withOpacity(.1)),
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/icons8-donate-64.png',
                      height: 40.h,
                      width: 40.w,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text("حمایت از تیم توسعه اپلیکیشن",
                        style: kMediumTextStyle.copyWith(
                            fontSize: 20.sp, color: Colors.black87)),
                    const SizedBox(
                      height: 3.5,
                    ),
                    Text(
                        "در صورت رضایت از اپلیکیشن میتوانید با مشاهده تبلیغات  و سپس با ثبت 5 امتیاز  از تیم توسعه اپلیکیشن حمایت کنید و مارا برای تولید محتوای جدید دلگرم کنید",
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style:
                            kMediumTextStyle.copyWith(color: Colors.black54)),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          InterstitialAds.showInterstitial(onClose: (close) {
                            _launchUrl(Uri.parse(
                                    'bazaar://details?id=com.pazhcc.contractsbank'))
                                .catchError((onError) {
                              Fluttertoast.showToast(
                                  msg: 'از نصب بودن کافه بازار مطمئن شوید!');
                            });
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16))),
                        child: Text(
                          'حمایت',
                          style: kMediumTextStyle,
                        ))
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(15.w, 0.h, 15.w, 10.h),
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        // floating: true,
        backgroundColor: kPrimaryColor,
        // forceElevated: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leadingWidth: 100.w,
        // title: Text(
        //   'مخزن قرارداد ها',
        //   style: kMediumTextStyle.copyWith(
        //       color: Colors.white,
        //       fontSize: 18.sp,
        //       fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    donationDialog(context);
                  },
                  icon: Image.asset(
                    'assets/img/icons8-donate-64(1).png',
                    height: 19.h,
                    width: 20.w,
                  )),
              IconButton(
                  onPressed: () async {
                    // showModalBottomSheet(
                    //     useSafeArea: true,
                    //     context: context,
                    //     builder: (_) => const RatingBarBottomSheet());
                    await Share.share(
                        'https://cafebazaar.ir/app/com.pazhcc.contractsbank',
                        subject:
                            'جامع ترین و کامل ترین اپلیکیشن مخزن نمونه قراردادهای کاربردی');
                  },
                  icon: const Icon(
                    Icons.share_rounded,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Text(
              'مخزن قرارداد ها',
              style: kMediumTextStyle.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

// class RatingBarBottomSheet extends StatelessWidget {
//   const RatingBarBottomSheet({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
//       height: MediaQuery.sizeOf(context).height * .35,
//       decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
//       alignment: Alignment.center,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           RatingBar(
//             initialRating: 5,
//             minRating: 3,
//             direction: Axis.horizontal,
//             itemCount: 5,
//             ratingWidget: RatingWidget(
//               full: const Icon(
//                 Icons.star_rounded,
//                 color: kPrimaryColor,
//               ),
//               half: const Icon(
//                 Icons.star_half_rounded,
//                 color: kPrimaryColor,
//               ),
//               empty: const Icon(
//                 Icons.star_outline_rounded,
//                 color: kPrimaryColor,
//               ),
//             ),
//             itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
//             onRatingUpdate: (rating) {
//               print(rating);
//             },
//           ),
//           Text(
//             '!با ثبت 5 امتیاز از ما حمایت کنید',
//             style: kMediumTextStyle.copyWith(color: Colors.black87),
//           ),
//           ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   backgroundColor: kPrimaryColor),
//               child: Text(
//                 'ثبت امتیاز',
//                 style: kMediumTextStyle,
//               ))
//         ],
//       ),
//     );
//   }
// }

class BuildImage extends StatelessWidget {
  final String imageName;
  const BuildImage({
    super.key,
    required this.imageName,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SvgPicture.asset(
      'assets/svg/$imageName.svg',
      height: 140.h,
      width: 145.w,
    ));
  }
}

class BuildMiddleBanner extends StatelessWidget {
  final String text;
  const BuildMiddleBanner({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
          child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: kGreenBoxDecoration,
        height: 35.h,
        width: 270.w,
        child: Text(
          text,
          textDirection: TextDirection.rtl,
          style: kMediumTextStyle.copyWith(
            color: Colors.white,
          ),
        ),
      )),
    );
  }
}

//// EXPANDABLE FAB ////

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomLeft,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56,
      height: 56,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: EdgeInsets.all(8.h),
              child: const Icon(
                Icons.close,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: kBackGroundColor,
            onPressed: _toggle,
            child: const Icon(
              Icons.menu,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          left: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class FakeItem extends StatelessWidget {
  const FakeItem({
    super.key,
    required this.isBig,
  });

  final bool isBig;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      height: isBig ? 128 : 36,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.grey.shade300,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math' as math;
import '../utils/const.dart';

class BuildAppbar extends StatelessWidget {
  const BuildAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      sliver: SliverAppBar(
        automaticallyImplyLeading: false,
        pinned: true,
        // floating: true,
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leadingWidth: 100.w,
        title: Text(
          'مخزن قرارداد ها',
          style: kMediumTextStyle.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 10.w),
        //   child: Row(
        //     children: [
        //       IconButton(
        //           onPressed: () {},
        //           icon: const Icon(
        //             ContractBankIcons.light_icon,
        //             color: Colors.white,
        //           )),
        //       IconButton(
        //           onPressed: () {},
        //           icon: const Icon(
        //             ContractBankIcons.star_icon,
        //             color: Colors.white,
        //           )),
        //     ],
        //   ),
        // ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 15.w),
        //     child: Text(
        //       'مخزن قرارداد ها',
        //       style: kMediumTextStyle.copyWith(
        //           color: Colors.white,
        //           fontSize: 18.sp,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   )
        // ],
      ),
    );
  }
}

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

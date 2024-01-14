import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:contracts_bank/features/article/presentation/widgets/menu_widgets.dart';

import '../../../../core/widgets/common_widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const BuildAppbar(),
        SliverToBoxAdapter(
          child: Image.asset(
            'assets/img/Pazh-cc-legalform02 1(1).png',
            height: 110.h,
            width: 190.w,
          ),
        ),
        const BuildMiddleBanner(text: 'مرکز قرارداد های پاژ'),
        const BuildMenu()
      ],
    );
  }
}

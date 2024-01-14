import 'package:flutter/material.dart';
import '../../../../core/widgets/common_widgets.dart';
import '../widgets/search_widgets.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        const BuildAppbar(),
        BuildSearchBox(),
        const BuildMiddleBanner(text: 'نتایج جستجو'),
        const BuildSearchList()
      ],
    );
  }
}

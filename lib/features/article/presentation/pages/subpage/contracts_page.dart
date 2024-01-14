import 'package:contracts_bank/config/routes/routes.dart';
import 'package:contracts_bank/core/utils/category_enum.dart';
import 'package:contracts_bank/features/article/presentation/provider/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:contracts_bank/core/widgets/common_widgets.dart';

import '../../widgets/contract_widgets.dart';

class ContractsPage extends StatelessWidget {
  const ContractsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Categorys;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await Provider.of<ArticleProvider>(context, listen: false)
                  .getArticle();
            },
            edgeOffset: 10.h,
            color: kPrimaryColor,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const BuildAppbar(),
                SliverToBoxAdapter(
                  child: SvgPicture.asset(
                    args.imagePath,
                    height: 140.h,
                    width: 145.w,
                  ),
                ),
                BuildMiddleBanner(text: 'نمونه قراردادهای ${args.title}'),
                BuildContractList(
                  categoryId: args.id,
                )
              ],
            ),
          ),
        ));
  }
}

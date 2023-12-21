import 'package:flutter/material.dart';
import 'package:contract_bank/core/widgets/common_widgets.dart';
import '../widgets/bookmark_widgets.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        BuildAppbar(),
        BuildImage(imageName: 'Bookmarks-pana 1'),
        BuildMiddleBanner(text: 'نشان شده ها'),

        /// BOOKMARK LIST
        BuildBookmarkList()
      ],
    );
  }
}

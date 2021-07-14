import 'package:flutter/material.dart';

import  'package:markets/generated/l10n.dart';
import '../elements/SearchWidget.dart';

class SearchBarWidget extends StatelessWidget {
  final ValueChanged onClickFilter;

  const SearchBarWidget({Key key, this.onClickFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(SearchModal());
      },
      child: Container(
        padding: EdgeInsets.all(9),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Theme.of(context).focusColor.withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(40)),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 0),
              child: Icon(Icons.search, color: Colors.grey.withOpacity(0.5)),
            ),
            Expanded(
              child: Text(
                "Search",
                // S.of(context).search_for_markets_or_products,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.caption.merge(TextStyle(fontSize: 13,color: Colors.grey.withOpacity(0.7))),
              ),
            ),

            SizedBox(width: 8),
            // InkWell(
            //   onTap: () {
            //     onClickFilter('e');
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(5)),
            //       color: Theme.of(context).focusColor.withOpacity(0.1),
            //     ),
            //     child: Wrap(
            //       crossAxisAlignment: WrapCrossAlignment.center,
            //       spacing: 4,
            //       children: [
            //         Text(
            //           S.of(context).filter,
            //           style: TextStyle(color: Theme.of(context).hintColor),
            //         ),
            //         Icon(
            //           Icons.filter_list,
            //           color: Theme.of(context).hintColor,
            //           size: 21,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

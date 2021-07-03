import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/market.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

// ignore: must_be_immutable
class CardWidget extends StatelessWidget {
  Market market;
  String heroTag;

  CardWidget({Key key, this.market, this.heroTag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 292,
      height: 100,
      margin: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // boxShadow: [
        //   BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 5)),
        // ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12,right: 12,top: 0,bottom: 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image of the card
                SizedBox(height: 20,),
                Hero(
                  tag: this.heroTag + market.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      height: 60,
                      width: 80,
                      fit: BoxFit.cover,
                      imageUrl: market.image.url,
                      placeholder: (context, url) => Image.asset(
                        'assets/img/loading.gif',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 60,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error_outline),
                    ),
                  ),
                ),
                Spacer(),
                // Row(
                //   children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                //       decoration: BoxDecoration(color: market.closed ? Colors.grey : Colors.green, borderRadius: BorderRadius.circular(24)),
                //       child: market.closed
                //           ? Text(
                //               S.of(context).closed,
                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                //             )
                //           : Text(
                //               S.of(context).open,
                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                //             ),
                //     ),
                //     Container(
                //       margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                //       padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                //       decoration: BoxDecoration(color: Helper.canDelivery(market) ? Colors.green : Colors.orange, borderRadius: BorderRadius.circular(24)),
                //       child: Helper.canDelivery(market)
                //           ? Text(
                //               S.of(context).delivery,
                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                //             )
                //           : Text(
                //               S.of(context).pickup,
                //               style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                //             ),
                //     ),
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        market.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        Helper.skipHtml(market.description),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: Helper.getStarsList(double.parse(market.rate)),
                      ),
                    ],
                  ),
                ),
                // )
              ],
            ),
            SizedBox(height: 12,),
            Divider(color: Colors.black.withOpacity(0.2),
            indent: 0,endIndent: 0,)
          ],
        ),


      ),
    );
  }
}

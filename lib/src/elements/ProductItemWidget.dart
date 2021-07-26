import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/product.dart';

import '../helpers/helper.dart';
import 'package:markets/src/models/product.dart';

class ProductItemWidget extends StatelessWidget {
  final String heroTag;
  final Product product;

  const ProductItemWidget({Key key, this.product, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String url = product.image.thumb;

    if(url!=null && ! url.contains("https")) {
      url = url.replaceFirst("http", "https");
    }

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {

        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductWidget(routeArgument: RouteArgument(param:  product.market.id),)));

        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductWidget(routeArgument: RouteArgument(param: product.market.id),)));

        //Navigator.of(context).pushNamed('/Pages', arguments: RouteArgument(id: "4",param: '${product.market.id}'));
      },
      child: Container(
        width: 100,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Container(
          width: 100,
          // margin: EdgeInsets.all(20),
          color: Colors.black,
          child:   Row(
           // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                    height: 140,
                    width: 160,
                    fit: BoxFit.cover,
                    imageUrl: url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 140,
                      width: 160,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
                  ),
             //   ),
            //  ),
              SizedBox(width: 5),
              // Flexible(
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              //       Expanded(
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: <Widget>[
              //             Text(
              //               product.name,
              //               overflow: TextOverflow.ellipsis,
              //               maxLines: 2,
              //               style: Theme.of(context).textTheme.subtitle1,
              //             ),
              //             Row(
              //               children: Helper.getStarsList(product.getRate()),
              //             ),
              //             Text(
              //               product.options.map((e) => e.name).toList().join(', '),
              //               overflow: TextOverflow.ellipsis,
              //               maxLines: 2,
              //               style: Theme.of(context).textTheme.caption,
              //             ),
              //           ],
              //         ),
              //       ),
              //       SizedBox(width: 8),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.end,
              //         children: <Widget>[
              //           Helper.getPrice(
              //             product.price,
              //             context,
              //             style: Theme.of(context).textTheme.headline4,
              //           ),
              //           product.discountPrice > 0
              //               ? Helper.getPrice(product.discountPrice, context,
              //               style: Theme.of(context).textTheme.bodyText2.merge(TextStyle(decoration: TextDecoration.lineThrough)))
              //               : SizedBox(height: 0),
              //         ],
              //       ),
              //     ],
              //   ),
              // )

            ],
          ),
        ),

      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/product_order.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart' as settingRepo;
class ProductOrderItemWidget extends StatelessWidget {
  final String heroTag;
  final ProductOrder productOrder;
  final Order order;

  const ProductOrderItemWidget({Key key, this.productOrder, this.order, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = productOrder.product.image.thumb;
    print('name ${productOrder.product.market.nameAr}');
    String lang = settingRepo.setting.value.mobileLanguage.value.languageCode;
    bool isArabic = lang=='ar';
    print('language is $lang isArabic $isArabic');
    if(!url.contains('https')){
      url = url.replaceFirst("http", "https");
    }
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).pushNamed('/OrderDetails', arguments: RouteArgument(id: order.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag + productOrder?.id,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl: url,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          isArabic?productOrder.product.nameAr:productOrder.product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Wrap(
                          children: List.generate(productOrder.options.length, (index) {
                            return Text(
                              productOrder.options.elementAt(index).name + ', ',
                              style: Theme.of(context).textTheme.caption,
                            );
                          }),
                        ),
                        Text(
                          isArabic?productOrder.product.market.nameAr:productOrder.product.market.name??"",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Helper.getPrice(Helper.getOrderPrice(productOrder), context, style: Theme.of(context).textTheme.subtitle1),
                      Text(
                        " x " + productOrder.quantity.toString(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

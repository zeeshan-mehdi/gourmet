import 'package:flutter/material.dart';
import 'package:markets/src/models/market.dart';

import '../helpers/helper.dart';
import '../models/favorite.dart';
import '../models/route_argument.dart';
import 'package:markets/src/repository/settings_repository.dart' as settingRepo;
// ignore: must_be_immutable
class FavoriteListItemWidget extends StatelessWidget {
  String heroTag;
  Favorite favorite;

  FavoriteListItemWidget({Key key, this.heroTag, this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String langCode = settingRepo.setting.value.mobileLanguage.value.languageCode;
    String url = this.favorite.product.image.thumb;

    if(url!=null&& url!=""&&!url.contains("https")){
      url = url.replaceFirst("http", "https");
    }


    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
       // Navigator.of(context).pushNamed('/Product', arguments: new RouteArgument(heroTag: this.heroTag, id: this.favorite.product.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag + favorite.product.id,
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          langCode=='en' ? favorite.product.name??'':favorite.product.nameAr??'',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          langCode=='en' ? favorite.product.market.name??'':favorite.product.market.nameAr??'',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Helper.getPrice(favorite.product.price, context, style: Theme.of(context).textTheme.headline4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



class FavoriteKitchenListItemWidget extends StatelessWidget {
  String heroTag;
  Favorite favorite;

  FavoriteKitchenListItemWidget({Key key, this.heroTag, this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = this.favorite.market.image.thumb;
    String langCode = settingRepo.setting.value.mobileLanguage.value.languageCode;

    if(url!=null&& url!=""&&!url.contains("https")){
      url = url.replaceFirst("http", "https");
    }

    String description;


    if(langCode =='en') {
      description = favorite.market.description != null && favorite.market.description.length > 50
          ? favorite.market.description.substring(0, 50)
          : favorite.market.description??'';
    }else{
      description = favorite.market.descriptionAr != null && favorite.market.descriptionAr.length > 50
          ? favorite.market.descriptionAr.substring(0, 50)
          : favorite.market.descriptionAr??'';
    }

    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
       // Navigator.of(context).pushNamed('/Product', arguments: new RouteArgument(heroTag: this.heroTag, id: this.favorite.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag:'$heroTag${favorite.id}',
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          langCode=='en' ? favorite.market.name??'':favorite.market.nameAr??'',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          langCode=='en' ? favorite.market.name??'':favorite.market.nameAr??'',
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    description,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    style: Theme.of(context).textTheme.caption,
                  ),
                //  Helper.getPrice(favorite.cuisine, context, style: Theme.of(context).textTheme.headline4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

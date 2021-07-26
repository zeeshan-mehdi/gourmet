import 'package:flutter/material.dart';
import 'package:markets/src/controllers/favorite_controller.dart';

import '../models/favorite.dart';
import '../models/route_argument.dart';

class FavoriteGridItemWidget extends StatelessWidget {
  final String heroTag;
  final Favorite favorite;

  final FavoriteController controller;

  FavoriteGridItemWidget({Key key, this.heroTag, this.favorite,this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String url = this.favorite.market.image.thumb;

    if(url!=null&& url!=""&&!url.contains("https")){
      url = url.replaceFirst("http", "https");
    }
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        //Navigator.of(context).pushNamed('/Product', arguments: new RouteArgument(heroTag: this.heroTag, id: this.favorite.product.id));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: '$heroTag${favorite.market?.id??''}',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                favorite.market.name,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                favorite.market.description!=null &&favorite.market.description.length>50?favorite.market.description.substring(0,50):favorite.market.description,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: MaterialButton(
              elevation: 0,
              padding: EdgeInsets.all(0),
              onPressed:(){},
              child: Icon(
                Icons.bookmark,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              color: Theme.of(context).accentColor.withOpacity(0.9),
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}



class FavoriteProductGridItemWidget extends StatelessWidget {
  final String heroTag;
  final Favorite favorite;

  FavoriteProductGridItemWidget({Key key, this.heroTag, this.favorite}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String url = this.favorite.product.image.thumb;

    if(url!=null&& url!=""&&!url.contains("https")){
      url = url.replaceFirst("http", "https");
    }

    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        //Navigator.of(context).pushNamed('/Product', arguments: new RouteArgument(heroTag: this.heroTag, id: this.favorite.product.id));
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Hero(
                  tag: '$heroTag${favorite.product?.id??''}',
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Text(
                favorite.product.name,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 2),
              Text(
                favorite.product.description!=null &&favorite.product.description.length>50?favorite.product.description.substring(0,50):favorite.product.description,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 40,
            height: 40,
            child: MaterialButton(
              elevation: 0,
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Icon(
                Icons.bookmark,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
              color: Theme.of(context).accentColor.withOpacity(0.9),
              shape: StadiumBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
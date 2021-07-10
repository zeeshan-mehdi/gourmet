import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/cart.dart';
import '../models/route_argument.dart';


class CartHeader extends StatelessWidget {
  final String market;
  final String marketAddress;

  const CartHeader({Key key, this.market, this.marketAddress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        border: Border(
          // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
          bottom: BorderSide(width: 1.0, color:Colors.black.withOpacity(0.1)),
        ),
        // boxShadow: [
        //   BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // ClipRRect(
          //   borderRadius: BorderRadius.all(Radius.circular(5)),
          //   child: CachedNetworkImage(
          //     height: 90,
          //     width: 90,
          //     fit: BoxFit.cover,
          //     imageUrl: widget.cart.product.image.thumb,
          //     placeholder: (context, url) => Image.asset(
          //       'assets/img/loading.gif',
          //       fit: BoxFit.cover,
          //       height: 90,
          //       width: 90,
          //     ),
          //     errorWidget: (context, url, error) => Icon(Icons.error_outline),
          //   ),
          // ),
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
                        '$market',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.black,fontSize: 30),
                      ),
                      // Wrap(
                      //   children: List.generate(widget.cart.options.length, (index) {
                      //     return Text(
                      //       widget.cart.options.elementAt(index).name + ', ',
                      //       style: Theme.of(context).textTheme.caption,
                      //     );
                      //   }),
                      // ),
                      Row(
                        children: [
                          Icon(Icons.location_pin,color:  Theme.of(context).hintColor.withOpacity(0.5),),
                          Text('$marketAddress', style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 20,color: Theme.of(context).hintColor.withOpacity(0.5))),
                        ],
                      ),

                      //Helper.getPrice(widget.cart.getProductPrice(), context, style: Theme.of(context).textTheme.headline4)
                    ],
                  ),
                ),




              ],
            ),
          )
        ],
      ),

    );
  }
}



class CartFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),

      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
          bottom: BorderSide(width: 1.0, color:Colors.black.withOpacity(0.1)),
        ),
        // boxShadow: [
        //   BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // ClipRRect(
          //   borderRadius: BorderRadius.all(Radius.circular(5)),
          //   child: CachedNetworkImage(
          //     height: 90,
          //     width: 90,
          //     fit: BoxFit.cover,
          //     imageUrl: widget.cart.product.image.thumb,
          //     placeholder: (context, url) => Image.asset(
          //       'assets/img/loading.gif',
          //       fit: BoxFit.cover,
          //       height: 90,
          //       width: 90,
          //     ),
          //     errorWidget: (context, url, error) => Icon(Icons.error_outline),
          //   ),
          // ),
          SizedBox(width: 15),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        child: Text(
                          'Add More',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.redAccent,fontSize: 20),
                        ),
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      // Wrap(
                      //   children: List.generate(widget.cart.options.length, (index) {
                      //     return Text(
                      //       widget.cart.options.elementAt(index).name + ', ',
                      //       style: Theme.of(context).textTheme.caption,
                      //     );
                      //   }),
                      // ),
                      // Row(
                      //   children: [
                      //     Icon(Icons.location_pin,color:  Theme.of(context).hintColor.withOpacity(0.5),),
                      //     Text('$marketAddress', style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 20,color: Theme.of(context).hintColor.withOpacity(0.5))),
                      //   ],
                      // ),

                      //Helper.getPrice(widget.cart.getProductPrice(), context, style: Theme.of(context).textTheme.headline4)
                    ],
                  ),
                ),




              ],
            ),
          )
        ],
      ),

    );
  }
}





// ignore: must_be_immutable
class CartItemWidget extends StatefulWidget {
  String heroTag;
  Cart cart;
  VoidCallback increment;
  VoidCallback decrement;
  VoidCallback onDismissed;

  CartItemWidget({Key key, this.cart, this.heroTag, this.increment, this.decrement, this.onDismissed}) : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.cart.id),
      onDismissed: (direction) {
        setState(() {
          widget.onDismissed();
        });
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          //Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: widget.cart.product.id, heroTag: widget.heroTag));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),

          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            border: Border(
             // top: BorderSide(width: 16.0, color: Colors.lightBlue.shade600),
              bottom: BorderSide(width: 1.0, color:Colors.black.withOpacity(0.1)),
            ),
            // boxShadow: [
            //   BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // ClipRRect(
              //   borderRadius: BorderRadius.all(Radius.circular(5)),
              //   child: CachedNetworkImage(
              //     height: 90,
              //     width: 90,
              //     fit: BoxFit.cover,
              //     imageUrl: widget.cart.product.image.thumb,
              //     placeholder: (context, url) => Image.asset(
              //       'assets/img/loading.gif',
              //       fit: BoxFit.cover,
              //       height: 90,
              //       width: 90,
              //     ),
              //     errorWidget: (context, url, error) => Icon(Icons.error_outline),
              //   ),
              // ),
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
                            widget.cart.product.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          // Wrap(
                          //   children: List.generate(widget.cart.options.length, (index) {
                          //     return Text(
                          //       widget.cart.options.elementAt(index).name + ', ',
                          //       style: Theme.of(context).textTheme.caption,
                          //     );
                          //   }),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('quantity:  ${widget.cart.quantity}', style: Theme.of(context).textTheme.subtitle1.copyWith(color: Theme.of(context).hintColor.withOpacity(0.5))),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 5,
                                children: <Widget>[
                                  Helper.getPrice(widget.cart.product.price, context, style: Theme.of(context).textTheme.bodyText1.copyWith(color: Theme.of(context).hintColor.withOpacity(0.5)), zeroPlaceholder: 'Free'),
                                  widget.cart.product.discountPrice > 0
                                      ? Helper.getPrice(widget.cart.product.discountPrice, context,
                                      style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(decoration: TextDecoration.lineThrough,color:  Theme.of(context).hintColor.withOpacity(0.5))))
                                      : SizedBox(height: 0),
                                ],
                              ),

                            ],
                          ),


                          //Helper.getPrice(widget.cart.getProductPrice(), context, style: Theme.of(context).textTheme.headline4)
                        ],
                      ),
                    ),




                  ],
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}




class KitchenCartItemWidget extends StatefulWidget {
  String heroTag;
  Cart cart;
  VoidCallback increment;
  VoidCallback decrement;
  VoidCallback onDismissed;

  KitchenCartItemWidget({Key key, this.cart, this.heroTag, this.increment, this.decrement, this.onDismissed}) : super(key: key);

  @override
  _KitchenCartItemWidgetState createState() => _KitchenCartItemWidgetState();
}

class _KitchenCartItemWidgetState extends State<KitchenCartItemWidget> {
  @override
  Widget build(BuildContext context) {

    String url = widget.cart.product.image.thumb;

    if(url!=null && !url.contains('https')){
      url  = url.replaceFirst("http", "https");
    }


    return Dismissible(
      key: Key(widget.cart.id),
      onDismissed: (direction) {
        setState(() {
          widget.onDismissed();
        });
      },
      child: InkWell(
        splashColor: Theme.of(context).accentColor,
        focusColor: Theme.of(context).accentColor,
        highlightColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).pushNamed('/Product', arguments: RouteArgument(id: widget.cart.product.id, heroTag: widget.heroTag));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.9),
            boxShadow: [
              BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: CachedNetworkImage(
                    height: 90,
                    fit: BoxFit.cover,
                    imageUrl: url,
                    placeholder: (context, url) => Image.asset(
                      'assets/img/loading.gif',
                      fit: BoxFit.cover,
                      height: 90,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error_outline),
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
                          Container(
                            child: Text(
                              widget.cart.product.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          Wrap(
                            children: List.generate(widget.cart.options.length, (index) {
                              return Text(
                                widget.cart.options.elementAt(index).name + ', ',
                                style: Theme.of(context).textTheme.caption,
                              );
                            }),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 5,
                            children: <Widget>[
                              Helper.getPrice(widget.cart.product.price, context, style: Theme.of(context).textTheme.subtitle2, zeroPlaceholder: 'Free'),
                              widget.cart.product.discountPrice > 0
                                  ? Helper.getPrice(widget.cart.product.discountPrice, context,
                                  style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(decoration: TextDecoration.lineThrough)))
                                  : SizedBox(height: 0),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.decrement();
                                  });
                                },
                                iconSize: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                icon: Icon(Icons.remove_circle_outline),
                                color: Theme.of(context).hintColor.withOpacity(0.5),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                child: Text(widget.cart.quantity.toString(), style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 24)),
                              ),

                              IconButton(

                                onPressed: () {
                                  setState(() {
                                    widget.increment();
                                  });
                                },
                                iconSize: 40,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                icon: Icon(Icons.add_circle_outline),
                                color: Theme.of(context).accentColor,
                              ),
                            ],
                          ),
                          //Helper.getPrice(widget.cart.getProductPrice(), context, style: Theme.of(context).textTheme.headline4)
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
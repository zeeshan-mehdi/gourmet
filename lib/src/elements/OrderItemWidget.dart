import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import  'package:markets/generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/route_argument.dart';
import 'ProductOrderItemWidget.dart';

class OrderItemWidget extends StatefulWidget {
  final bool expanded;
  final Order order;
  final ValueChanged<void> onCanceled;

  OrderItemWidget({Key key, this.expanded, this.order, this.onCanceled}) : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {


  @override
  Widget build(BuildContext context) {

    print('order status ${widget.order.orderStatus.id}');

    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: widget.order.active ? 1 : 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 0),
                padding: EdgeInsets.only(top: 0, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // boxShadow: [
                  //   BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.1), blurRadius: 5, offset: Offset(0, 2)),
                  // ],
                ),
                child: Theme(
                  data: theme,
                  child: Column(
                    children: [
                      ExpansionTile(
                        initiallyExpanded: widget.expanded,
                        title: Column(
                          children: <Widget>[
                            //Text('${S.of(context).order_id}: #${widget.order.id}'),
                            Text('${widget.order.user.name}',style: Theme.of(context).textTheme.headline4,),
                            SizedBox(height:7),
                            Text(
                              DateFormat('dd-MM-yyyy | HH:mm').format(widget.order.dateTime),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Helper.getPrice(Helper.getTotalOrdersPrice(widget.order), context, style: Theme.of(context).textTheme.headline4),
                            Container(
                              width: 60,
                              height: 56,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(

                                    image: NetworkImage('${widget.order.user.image.url}'),
                                    // image: NetworkImage('https://googleflutter.com/sample_image.jpg'),
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                            // Text(
                            //   '${widget.order.payment.method}',
                            //   style: Theme.of(context).textTheme.caption,
                            //  )
                            // Divider(color: Colors.black.withOpacity(0.2),thickness: 1,),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                              children: List.generate(
                                widget.order.productOrders.length,
                                    (indexProduct) {
                                  return ProductOrderItemWidget(heroTag: 'mywidget.orders', order: widget.order, productOrder: widget.order.productOrders.elementAt(indexProduct));
                                },
                              )),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        S.of(context).delivery_fee,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                    Helper.getPrice(widget.order.deliveryFee, context, style: Theme.of(context).textTheme.subtitle1)
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        '${S.of(context).tax} (${widget.order.tax}%)',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                    Helper.getPrice(Helper.getTaxOrder(widget.order), context, style: Theme.of(context).textTheme.subtitle1)
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        S.of(context).total,
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),
                                    Helper.getPrice(Helper.getTotalOrdersPrice(widget.order), context, style: Theme.of(context).textTheme.headline4)
                                  ],
                                ),

                                SizedBox(height: 10,),

                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                       'Order Status',
                                        style: Theme.of(context).textTheme.bodyText1,
                                      ),
                                    ),

                                    Container(
                                      height: 25,
                                      margin: EdgeInsets.all(0),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:12.0,),
                                        child: Center(child: Text( widget.order.orderStatus.status, style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 12,color: Colors.white))),
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: widget.order.orderStatus.id == "5" ? Colors.green   :  widget.order.orderStatus.id == "7" ?  Colors.red :  Theme.of(context).accentColor),
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                          color: widget.order.orderStatus.id == "5" ? Colors.green   :  widget.order.orderStatus.id == "7" ?   Colors.red :  Theme.of(context).accentColor
                                      ),
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(color: Colors.black.withOpacity(0.3),indent: 18,endIndent: 18,)
                    ],
                  )
                ),
              ),

              // Container(
              //   child: Wrap(
              //     alignment: WrapAlignment.end,
              //     children: <Widget>[
              //       MaterialButton(
              //         elevation: 0,
              //         onPressed: () {
              //           Navigator.of(context).pushNamed('/Tracking', arguments: RouteArgument(id: widget.order.id));
              //         },
              //         textColor: Theme.of(context).hintColor,
              //         child: Wrap(
              //           children: <Widget>[Text(S.of(context).view)],
              //         ),
              //         padding: EdgeInsets.symmetric(horizontal: 0),
              //       ),
              //       if (widget.order.canCancelOrder())
              //         MaterialButton(
              //           elevation: 0,
              //           onPressed: () {
              //             showDialog(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 // return object of type Dialog
              //                 return AlertDialog(
              //                   title: Wrap(
              //                     spacing: 10,
              //                     children: <Widget>[
              //                       Icon(Icons.report_outlined, color: Colors.orange),
              //                       Text(
              //                         S.of(context).confirmation,
              //                         style: TextStyle(color: Colors.orange),
              //                       ),
              //                     ],
              //                   ),
              //                   content: Text(S.of(context).areYouSureYouWantToCancelThisOrder),
              //                   contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
              //                   actions: <Widget>[
              //                     MaterialButton(
              //                       elevation: 0,
              //                       child: new Text(
              //                         S.of(context).yes,
              //                         style: TextStyle(color: Theme.of(context).hintColor),
              //                       ),
              //                       onPressed: () {
              //                         widget.onCanceled(widget.order);
              //                         Navigator.of(context).pop();
              //                       },
              //                     ),
              //                     MaterialButton(
              //                       elevation: 0,
              //                       child: new Text(
              //                         S.of(context).close,
              //                         style: TextStyle(color: Colors.orange),
              //                       ),
              //                       onPressed: () {
              //                         Navigator.of(context).pop();
              //                       },
              //                     ),
              //                   ],
              //                 );
              //               },
              //             );
              //           },
              //           textColor: Theme.of(context).hintColor,
              //           child: Wrap(
              //             children: <Widget>[Text(S.of(context).cancel + " ")],
              //           ),
              //           padding: EdgeInsets.symmetric(horizontal: 10),
              //         ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
        // Container(
        //   margin: EdgeInsetsDirectional.only(start: 20),
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   height: 28,
        //   width: 140,
        //   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100)), color: widget.order.active ? Theme.of(context).accentColor : Colors.redAccent),
        //   alignment: AlignmentDirectional.center,
        //   child: Text(
        //     widget.order.active ? '${widget.order.orderStatus.status}' : S.of(context).canceled,
        //     maxLines: 1,
        //     overflow: TextOverflow.fade,
        //     softWrap: false,
        //     style: Theme.of(context).textTheme.caption.merge(TextStyle(height: 1, color: Theme.of(context).primaryColor)),
        //   ),
        // ),
      ],
    );
  }
}

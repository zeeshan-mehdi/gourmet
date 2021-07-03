
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/app_config.dart' as config;
import '../helpers/helper.dart';
import '../models/route_argument.dart';
import '../models/slide.dart';
import 'HomeSliderLoaderWidget.dart';

class LoginSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _LoginSliderWidgetState createState() => _LoginSliderWidgetState();

  LoginSliderWidget({Key key, this.slides}) : super(key: key);
}

class _LoginSliderWidgetState extends State<LoginSliderWidget> {
  int _current = 0;
  AlignmentDirectional _alignmentDirectional;

  @override
  Widget build(BuildContext context) {
    return widget.slides == null || widget.slides.isEmpty
        ? HomeSliderLoaderWidget()
        : Stack(
      alignment: _alignmentDirectional ?? Helper.getAlignmentDirectional(widget.slides.elementAt(0).textPosition),
      fit: StackFit.passthrough,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
           // height: 140,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
                _alignmentDirectional = Helper.getAlignmentDirectional(widget.slides.elementAt(index).textPosition);
              });
            },
          ),
          items: widget.slides.map((Slide slide) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                 // margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  height: 270,
                  decoration: BoxDecoration(
                    boxShadow: [
                    //  BoxShadow(color: Colors.transparent, blurRadius: 15, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                          height: 195,
                          width: double.infinity,
                          fit: Helper.getBoxFit(slide.imageFit),
                          imageUrl: slide.image.url,
                          placeholder: (context, url) => Image.asset(
                            'assets/img/loading.gif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.error_outline),
                        ),
                     // ),
                      // SizedBox(height: 5,),
                       Container(
                         transform: Matrix4.translationValues(0.0, -24.0, 0.0),
                          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: widget.slides.map((Slide slide) {
                              return Container(
                                width: 4.0,
                                height: 3.0,
                                //   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    color: _current == widget.slides.indexOf(slide)
                                        ? Helper.of(context).getColorFromHex(slide.indicatorColor)
                                        : Helper.of(context).getColorFromHex(slide.indicatorColor).withOpacity(0.3)),
                              );
                            }).toList(),
                          ),
                        ),
                     // )
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),


       // ),

      ],
    );
  }
}
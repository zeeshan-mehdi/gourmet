
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

class SplashSliderWidget extends StatefulWidget {
  final List<Slide> slides;

  @override
  _SplashSliderWidgetState createState() => _SplashSliderWidgetState();

  SplashSliderWidget({Key key, this.slides}) : super(key: key);
}

class _SplashSliderWidgetState extends State<SplashSliderWidget> {
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
             height: 400,
          //  viewportFraction: 1.0,
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
                //  height: 380,
                  decoration: BoxDecoration(
                    boxShadow: [
                      //  BoxShadow(color: Colors.transparent, blurRadius: 15, offset: Offset(0, 2)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CachedNetworkImage(
                        height: 220,
                        width: double.infinity,
                        fit: Helper.getBoxFit(slide.imageFit),
                        imageUrl: slide.image.url,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.fill,
                          width: double.infinity,
                         // height: 200,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                      ),
                      // ),
                       SizedBox(height: 20,),
                      Text(
                        "Gourment \n Walkthrough \n Slide One",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "With Gourmet, Your favorit home made \n meal is closer than ever",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 12,fontWeight: FontWeight.w500),
                      ),
                      Container(
                        transform: Matrix4.translationValues(0.0, 20.0, 0.0),
                        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: widget.slides.map((Slide slide) {
                            return Container(
                              width: 18.0,
                              height: 3.0,
                                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  color: _current == widget.slides.indexOf(slide)
                                      ? Colors.orangeAccent
                                      :  Colors.orangeAccent.withOpacity(0.3)),
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
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import '../repository/settings_repository.dart' as settingRepo;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../controllers/market_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/GalleryCarouselWidget.dart';
import '../elements/ProductItemWidget.dart';
import '../elements/ReviewsListWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

import 'package:path/path.dart' as p;

class DetailsWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  DetailsWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _DetailsWidgetState createState() {
    return _DetailsWidgetState();
  }
}

class _DetailsWidgetState extends StateMVC<DetailsWidget> {
  MarketController _con;
  bool loading = false;

  _DetailsWidgetState() : super(MarketController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForMarket(id: widget.routeArgument.id);
    _con.listenForGalleries(widget.routeArgument.id);
    _con.listenForFeaturedProducts(widget.routeArgument.id);
    _con.listenForMarketReviews(id: widget.routeArgument.id);
    super.initState();
  }

  Future<String> createQrPicture(String qr) async {
    final qrValidationResult = QrValidator.validate(
      data: qr,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';
    final picData = await painter.toImageData(2048, format: ImageByteFormat.png);
    await writeToFile(picData, path);
    return path;
  }
  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
    );
  }

  Future shareFile(String qr)async{
    setState(() {loading = true;});
    String path = await createQrPicture(qr);

    await Share.shareFiles(
        [path],
        mimeTypes: ["image/png"],
        subject: 'Scan to find kitchen',
        text: 'Please scan me'
    );
    setState(() {loading = false;});
  }

  @override
  Widget build(BuildContext context) {
    String url = _con.market?.image?.url??null;

    String lang = settingRepo.setting.value.mobileLanguage.value.languageCode;
    bool isArabic = lang=='ar';

    if(url!=null && !url.contains('https')){
      url = url.replaceFirst('http', 'https');
    }
    return Scaffold(
        key: _con.scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: RefreshIndicator(
          onRefresh: _con.refreshMarket,
          child: _con.market == null
              ? CircularLoadingWidget(height: 500)
              : CustomScrollView(
                  primary: true,
                  shrinkWrap: false,
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                      expandedHeight: 300,
                      elevation: 0,
                      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Hero(
                          tag: (widget?.routeArgument?.heroTag ?? '') + _con.market.id,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: url,
                            placeholder: (context, url) => Image.asset(
                              'assets/img/loading.gif',
                              fit: BoxFit.cover,
                            ),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 25),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    isArabic?_con.market?.nameAr:_con.market?.name ?? '',
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                                SizedBox(
                                  height: 32,
                                  child: Chip(
                                    padding: EdgeInsets.all(0),
                                    label: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(_con.market.rate, style: Theme.of(context).textTheme.bodyText1.merge(TextStyle(color: Theme.of(context).primaryColor))),
                                        Icon(
                                          Icons.star_border,
                                          color: Theme.of(context).primaryColor,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                    backgroundColor: Theme.of(context).accentColor.withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 20),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                decoration: BoxDecoration(color: _con.market.closed ? Colors.grey : Colors.green, borderRadius: BorderRadius.circular(24)),
                                child: _con.market.closed
                                    ? Text(
                                        S.of(context).closed,
                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                      )
                                    : Text(
                                        S.of(context).open,
                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                      ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                decoration: BoxDecoration(color: _con.market.availableForDelivery ? Colors.green : Colors.orange, borderRadius: BorderRadius.circular(24)),
                                child: _con.market.availableForDelivery
                                    ? Text(
                                        S.of(context).delivery,
                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                      )
                                    : Text(
                                        S.of(context).pickup,
                                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).primaryColor)),
                                      ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            child: Helper.applyHtml(context,isArabic?_con.market?.descriptionAr??'': _con.market.description??''),
                          ),
                          ImageThumbCarouselWidget(galleriesList: _con.galleries),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              leading: Icon(
                                Icons.stars,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                S.of(context).information,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            child: Helper.applyHtml(context, isArabic?_con.market?.informationAr:_con.market.information),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _con.market.address ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: MaterialButton(
                                    elevation: 0,
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/Pages', arguments: new RouteArgument(id: '1', param: _con.market));
                                    },
                                    child: Icon(
                                      Icons.directions,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                    color: Theme.of(context).accentColor.withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    '${_con.market.phone} \n${_con.market.mobile}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: MaterialButton(
                                    elevation: 0,
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      launch("tel:${_con.market.mobile}");
                                    },
                                    child: Icon(
                                      Icons.call,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                    color: Theme.of(context).accentColor.withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _con.featuredProducts.isEmpty
                              ? SizedBox(height: 0)
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                                    leading: Icon(
                                      Icons.shopping_basket,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    title: Text(
                                      S.of(context).featuredProducts,
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ),
                          _con.featuredProducts.isEmpty
                              ? SizedBox(height: 0)
                              : ListView.separated(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: _con.featuredProducts.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10);
                                  },
                                  itemBuilder: (context, index) {
                                    return ProductItemWidget(
                                      heroTag: 'details_featured_product',
                                      product: _con.featuredProducts.elementAt(index),
                                    );
                                  },
                                ),
                          SizedBox(height: 100),
                          _con.reviews.isEmpty
                              ? SizedBox(height: 5)
                              : Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                                    leading: Icon(
                                      Icons.recent_actors,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    title: Text(
                                      S.of(context).whatTheySay,
                                      style: Theme.of(context).textTheme.headline4,
                                    ),
                                  ),
                                ),
                          _con.reviews.isEmpty
                              ? SizedBox(height: 5)
                              : Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: ReviewsListWidget(reviewsList: _con.reviews),
                                ),
                           loading ? Center(child: CircularProgressIndicator()) :  Row(
                            children: [
                              QrImage(
                                data: '${_con.market.id}',
                                version: QrVersions.auto,
                                size: MediaQuery.of(context).size.width-100,
                                gapless: false,
                              ),
                              IconButton(icon: Icon(Icons.share,color: Theme.of(context).accentColor,), onPressed:()=> shareFile(_con.market.id))
                            ],
                          )
                        ],
                      ),
                    ),



                  ],
                ),
        ));
  }
}

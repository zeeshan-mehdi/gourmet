import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markets/src/elements/ProfileKitchenSection.dart';

import '../repository/settings_repository.dart';
import '../repository/user_repository.dart';
import '../../generated/l10n.dart';
class KitchenProfile extends StatefulWidget {
  @override
  _KitchenProfileState createState() => _KitchenProfileState();
}

class _KitchenProfileState extends State<KitchenProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
             currentUser.value.apiToken != null
                ? UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
              ),
              accountName: Text(
                currentUser.value.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              accountEmail: Text(
                currentUser.value.email,
                style: Theme.of(context).textTheme.caption,
              ),
              currentAccountPicture: Stack(
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      child: CachedNetworkImage(
                        height: 80,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: currentUser.value.image.thumb,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 80,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error_outline),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: currentUser.value.verifiedPhone ?? false
                        ? Icon(
                      Icons.check_circle,
                      color: Theme.of(context).accentColor,
                      size: 24,
                    )
                        : SizedBox(),
                  )
                ],
              ),
            )
                : Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(0.1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(S.of(context).welcome, style: Theme.of(context).textTheme.headline4.merge(TextStyle(color: Theme.of(context).accentColor))),
                  SizedBox(height: 5),
                  Text(S.of(context).loginAccountOrCreateNewOneForFree, style: Theme.of(context).textTheme.bodyText2),
                  SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    children: <Widget>[
                      MaterialButton(
                        elevation: 0,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/Login');
                        },
                        color: Theme.of(context).accentColor,
                        height: 40,
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 9,
                          children: [
                            Icon(Icons.exit_to_app_outlined, color: Theme.of(context).primaryColor, size: 24),
                            Text(
                              S.of(context).login,
                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ),
                        shape: StadiumBorder(),
                      ),
                      MaterialButton(
                        elevation: 0,
                        color: Theme.of(context).focusColor.withOpacity(0.2),
                        height: 40,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/SignUp');
                        },
                        child: Wrap(
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 9,
                          children: [
                            Icon(Icons.person_add_outlined, color: Theme.of(context).hintColor, size: 24),
                            Text(
                              S.of(context).register,
                              style: Theme.of(context).textTheme.subtitle2.merge(TextStyle(color: Theme.of(context).hintColor)),
                            ),
                          ],
                        ),
                        shape: StadiumBorder(),
                      ),
                    ],
                  ),
                ],
              ),
            ),


            ProfileKitchenSection(),

            SizedBox(height: 100,),

            ProfileKitchenSection(),

          ],
        ),
      ),
    );
  }
}



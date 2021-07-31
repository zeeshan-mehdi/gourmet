
import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/controllers/staff_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class RestaurantStaff extends StatefulWidget {
  @override
  _RestaurantStaffState createState() => _RestaurantStaffState();
}

class _RestaurantStaffState extends StateMVC<RestaurantStaff> {

  StaffController _con;


  _RestaurantStaffState(){
    _con = StaffController();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Restaurant Staff',
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).hintColor,
        ),

        automaticallyImplyLeading: false,

        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      // floatingActionButton: _con.cart != null && _con.cart.product.market.availableForDelivery
      //     ?

      body: Container(
        child: ListView.builder(
            itemCount: _con.users.length,
            itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading:CircleAvatar(
                backgroundImage: NetworkImage(
                  _con.users[index].image.url
                ),
              ),

              title: Text(_con.users[index].name),

            ),
          );
        }),
      ),

      floatingActionButton : FloatingActionButton(
          onPressed: () async {

            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Material(child: AddNewAddress())));


            // LocationResult result = await showLocationPicker(
            //   context,
            //   setting.value.googleMapsKey,
            //   initialCenter: LatLng(deliveryAddress.value?.latitude ?? 0, deliveryAddress.value?.longitude ?? 0),
            //   //automaticallyAnimateToCurrentLocation: true,
            //   //mapStylePath: 'assets/mapStyle.json',
            //   myLocationButtonEnabled: true,
            //   //resultCardAlignment: Alignment.bottomCenter,
            // );
            // _con.addAddress(new Address.fromJSON({
            //   'address': result.address,
            //   'latitude': result.latLng.latitude,
            //   'longitude': result.latLng.longitude,
            // }));
            // print("result = $result");
            //setState(() => _pickedLocation = result);
          },
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColor,
          )),
      // : SizedBox(height: 0),
      // body: RefreshIndicator(
      //   onRefresh: _con.refreshAddresses,
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       mainAxisSize: MainAxisSize.max,
      //       children: <Widget>[
      //         Padding(
      //           padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      //           child: ListTile(
      //             contentPadding: EdgeInsets.symmetric(vertical: 0),
      //             leading: Icon(
      //               Icons.map_outlined,
      //               color: Theme.of(context).hintColor,
      //             ),
      //             title: Text(
      //               S.of(context).delivery_addresses,
      //               maxLines: 1,
      //               overflow: TextOverflow.ellipsis,
      //               style: Theme.of(context).textTheme.headline4,
      //             ),
      //             subtitle: Text(
      //               S.of(context).long_press_to_edit_item_swipe_item_to_delete_it,
      //               maxLines: 2,
      //               overflow: TextOverflow.ellipsis,
      //               style: Theme.of(context).textTheme.caption,
      //             ),
      //           ),
      //         ),
      //         _con.addresses.isEmpty
      //             ? CircularLoadingWidget(height: 250)
      //             : ListView.separated(
      //           padding: EdgeInsets.symmetric(vertical: 15),
      //           scrollDirection: Axis.vertical,
      //           shrinkWrap: true,
      //           primary: false,
      //           itemCount: _con.addresses.length,
      //           separatorBuilder: (context, index) {
      //             return SizedBox(height: 15);
      //           },
      //           itemBuilder: (context, index) {
      //             return DeliveryAddressesItemWidget(
      //               address: _con.addresses.elementAt(index),
      //               onPressed: (Address _address) {
      //                 DeliveryAddressDialog(
      //                   context: context,
      //                   address: _address,
      //                   onChanged: (Address _address) {
      //                     _con.updateAddress(_address);
      //                   },
      //                 );
      //               },
      //               onLongPress: (Address _address) {
      //                 DeliveryAddressDialog(
      //                   context: context,
      //                   address: _address,
      //                   onChanged: (Address _address) {
      //                     _con.updateAddress(_address);
      //                   },
      //                 );
      //               },
      //               onDismissed: (Address _address) {
      //                 _con.removeDeliveryAddress(_address);
      //               },
      //             );
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

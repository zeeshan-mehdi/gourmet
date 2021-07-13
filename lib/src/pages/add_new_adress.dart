import 'package:country_pickers/country.dart' as picker_country;
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart' as picker;
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:markets/src/controllers/delivery_addresses_controller.dart';
import 'package:markets/src/models/address.dart';

import 'package:markets/generated/l10n.dart';
import 'package:markets/src/repository/settings_repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends StateMVC<AddNewAddress> {

  DeliveryAddressesController _con;

  _AddNewAddressState() : super(DeliveryAddressesController()) {
    _con = controller;
  }



  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _wayController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _jadaController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();

  var emirate = 'Dubai';

  var governorate = 'Capital Governorate';

  var province = 'Riyadh';


  final _lastNameNode = FocusNode();
  final _phoneNode = FocusNode();
  final _emailNode = FocusNode();
  final _cityNode = FocusNode();
  final _streetNode = FocusNode();
  final _blockNode = FocusNode();
  final _zipNode = FocusNode();
  final _stateNode = FocusNode();
  final _countryNode = FocusNode();
  final _apartmentNode = FocusNode();
  final _wayNode = FocusNode();
  final _areaNode = FocusNode();
  final _jadaNode = FocusNode();
  final _provinceNode = FocusNode();
  final _governorateNode = FocusNode();
  final _emirateNode = FocusNode();
  final _houseNode = FocusNode();
  final _floorNode = FocusNode();
  final _longitudeNode = FocusNode();
  final _latitudeNode = FocusNode();


  String countryName;
  Address address = new Address();
  List<Country> countries = [];
  List<dynamic> states = [];

  var isBuildingChecked = false;


  @override
  void dispose() {
    _cityController.dispose();
    _streetController.dispose();
    _blockController.dispose();
    _zipController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _apartmentController.dispose();

    _lastNameNode.dispose();
    _phoneNode.dispose();
    _emailNode.dispose();
    _cityNode.dispose();
    _streetNode.dispose();
    _blockNode.dispose();
    _zipNode.dispose();
    _stateNode.dispose();
    _countryNode.dispose();
    _apartmentNode.dispose();
    _wayController.dispose();
    _areaController.dispose();
    _jadaController.dispose();
    _houseController.dispose();
    _floorController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var countryName = 'Kuwait';
    if (_countryController.text.isNotEmpty) {
      try {
        countryName = picker.CountryPickerUtils
            .getCountryByIsoCode(
            _countryController.text)
            .name;
      } catch (e) {
        countryName = 'Kuwait';
      }
    }


    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          S.of(context).add_delivery_address,
          style: Theme.of(context).textTheme.headline6.merge(TextStyle(letterSpacing: 1.3)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/Pages', arguments: 11);
          },
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).hintColor,
        ),

        automaticallyImplyLeading: false,

        // actions: <Widget>[
        //   new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
        // ],
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(

              children: [

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context)
                        .country,
                    style:  Theme.of(context).textTheme.caption.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ),
                (countries.length == 1)
                    ? Text(
                  picker.CountryPickerUtils
                      .getCountryByIsoCode(countries[0].iso3Code)
                      .name,
                  style: const TextStyle(fontSize: 18,color: Colors.black),
                )
                    : GestureDetector(
                  onTap: _openCountryPickerDialog,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(countryName,
                                style: const TextStyle(fontSize: 17.0)),
                          ),
                          const Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Theme.of(context).hintColor,
                    )
                  ]),
                ),
                //renderStateInput(),

                countryName?.toLowerCase() == 'kuwait'
                    ? renderAreaInput()
                    : Container(),

                countryName?.toLowerCase() == 'bahrain'
                    ? renderGovernorateInput()
                    : Container(),
                countryName?.toLowerCase() == 'oman'
                    ? renderAreaInput()
                    : Container(),
                countryName?.toLowerCase() == 'bahrain'
                    ? renderAreaInput()
                    : Container(),

                countryName?.toLowerCase() == 'kuwait' ||
                    countryName?.toLowerCase() == 'oman' ||
                    countryName?.toLowerCase() == 'bahrain' ? TextFormField(
                    controller: _blockController,
                    focusNode: _blockNode,
                    validator: (val) {
                      return null;
                    },
                    decoration:
                    InputDecoration(labelText: S
                        .of(context)
                        .streetNameBlock,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_areaNode),
                    onSaved: (String value) {
                      address.block = value;
                      address.emirate = null;
                    }) : Container(),

                countryName?.toLowerCase() == 'qatar'
                    ? renderAreaInput()
                    : Container(),
                countryName?.toLowerCase() == 'saudi arabia'
                    ? renderProvinceInput()
                    : Container(),
                //countryName?.toLowerCase() == 'united arab emirates'? renderGovernorateInput():Container(),
                countryName?.toLowerCase() == 'united arab emirates'
                    ? renderEmiratesInput()
                    : Container(),


                countryName?.toLowerCase() == 'united arab emirates' ||
                    countryName?.toLowerCase() == "saudi arabia" ? TextFormField(
                  controller: _cityController,
                  focusNode: _cityNode,
                  validator: (val) {
                    return val.isEmpty ? S
                        .of(context)
                        .cityIsRequired : null;
                  },
                  decoration: InputDecoration(labelText: S
                      .of(context)
                      .city,

                    labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                    fillColor: Colors.white,
                    focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.5),
                        width: 2.0,
                      ),
                    ),

                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_streetNode),
                  onSaved: (String value) {
                    address.city = value;
                  },
                ) : Container(),
                TextFormField(
                    controller: _streetController,
                    focusNode: _streetNode,
                    validator: (val) {
                      return val.isEmpty ? S
                          .of(context)
                          .streetIsRequired : null;
                    },
                    decoration: InputDecoration(labelText: S
                        .of(context)
                        .streetName,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_houseNode),
                    onSaved: (String value) {
                      address.street = value;
                    }),
                countryName?.toLowerCase() == 'oman' ? renderWayInput() : Container(),
                countryName?.toLowerCase() == 'kuwait'
                    ? renderJadaInput()
                    : Container(),

                TextFormField(
                    controller: _houseController,
                    focusNode: _houseNode,
                    validator: (val) {
                      return null;
                    },
                    decoration:
                    InputDecoration(labelText: S
                        .of(context)
                        .house,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_streetNode),
                    onSaved: (String value) {
                      address.house = value;
                    }),


                // TextFormField(
                //     controller: _zipController,
                //     focusNode: _zipNode,
                //     validator: (val) {
                //       return val.isEmpty ? S.of(context).zipCodeIsRequired : null;
                //     },
                //     keyboardType: (kPaymentConfig['EnableAlphanumericZipCode'] ?? false)
                //         ? TextInputType.text
                //         : TextInputType.number,
                //     textInputAction: TextInputAction.done,
                //     decoration: InputDecoration(labelText: S.of(context).zipCode),
                //     onSaved: (String value) {
                //       address.zipCode = value;
                //     }),



                Padding(
                  padding: const EdgeInsets.symmetric(vertical:18.0),
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () async{
                      LocationResult result = await showLocationPicker(
                        context,
                        setting.value.googleMapsKey,
                        initialCenter: LatLng(deliveryAddress.value?.latitude ?? 0, deliveryAddress.value?.longitude ?? 0),
                        //automaticallyAnimateToCurrentLocation: true,
                        //mapStylePath: 'assets/mapStyle.json',
                        myLocationButtonEnabled: true,
                        //resultCardAlignment: Alignment.bottomCenter,
                      );


                      address.latitude = result.latLng.latitude;
                      address.longitude = result.latLng.longitude;
                      address.address = result.address;

                      _latitudeController.text =  address.latitude.toString();
                      _longitudeController.text =  address.longitude.toString();


                      // _con.addAddress(new Address.fromJSON({
                      //   'address': result.address,
                      //   'latitude': result.latLng.latitude,
                      //   'longitude': result.latLng.longitude,
                      // }));
                      // print("result = $result");
                      //setState(() => _pickedLocation = result);
                      //Navigator.of(context).pushNamed('/Cart',arguments: RouteArgument(param: _con.scaffoldKey));
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).focusColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: Text(
                        S.of(context).pick_location,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),

                TextFormField(
                    controller: _latitudeController,
                    focusNode: _latitudeNode,
                    validator: (val) {
                      return null;
                    },
                    decoration:
                    InputDecoration(labelText: S
                        .of(context)
                        .latitude,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_streetNode),
                    onSaved: (String value) {
                      address.latitude = double.parse(value);
                    }),
                TextFormField(
                    controller: _longitudeController,
                    focusNode: _longitudeNode,
                    validator: (val) {
                      return null;
                    },
                    decoration:
                    InputDecoration(labelText: S
                        .of(context)
                        .longitude,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_streetNode),
                    onSaved: (String value) {
                      address.longitude = double.parse(value);
                    }),



                Align(

                  child: Row(
                    children: [
                      Text('Building',style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),),
                      Checkbox(
                          value: isBuildingChecked,
                          onChanged: (val) {
                            setState(() {
                              isBuildingChecked = val;
                            });
                          }
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,

                ),

                isBuildingChecked ? TextFormField(
                    controller: _floorController,
                    focusNode: _floorNode,

                    decoration: InputDecoration(labelText: S
                        .of(context)
                        .floor,
                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_apartmentNode),
                    onSaved: (String value) {
                      address.floor = value;
                    }) : Container(),


                isBuildingChecked ? TextFormField(
                    controller: _apartmentController,
                    focusNode: _apartmentNode,

                    decoration: InputDecoration(labelText: S
                        .of(context)
                        .apartmentNumber,

                      labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
                      fillColor: Colors.white,
                      focusedBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(
                          color: Colors.black.withOpacity(0.5),
                          width: 2.0,
                        ),
                      ),

                    ),
                    textInputAction: TextInputAction.next,

                    onSaved: (String value) {
                      address.apartment = value;
                    }) : Container(),



                Padding(
                  padding: const EdgeInsets.symmetric(vertical:18.0),
                  child: MaterialButton(
                    elevation: 0,
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        _con.addAddress(address);
                        Navigator.of(context).pushNamed('/Pages',arguments: 11);
                      }
                      //Navigator.of(context).pushNamed('/Cart',arguments: RouteArgument(param: _con.scaffoldKey));
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20),
                      child: Text(
                        S.of(context).save,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _openCountryPickerDialog() =>
      showDialog(
          context: context,
          builder: (contextBuilder) =>
              Theme(
                data: Theme.of(context).copyWith(primaryColor: Colors.pink),
                child: Container(
                  height: 500,
                  child: picker.CountryPickerDialog(
                      titlePadding: const EdgeInsets.all(8.0),
                      contentPadding: const EdgeInsets.all(2.0),
                      searchCursorColor: Colors.pinkAccent,
                      searchInputDecoration:
                      const InputDecoration(hintText: 'Search...'),
                      isSearchable: true,
                      title: Text('Kuwait'),
                      onValuePicked: (picker_country.Country country) async {
                        _countryController.text = country.isoCode;
                         address.country = country.isoCode;
                        if (mounted) {
                          setState(() {});
                        }
                       // final c =
                        //Country(iso3Code: country.isoCode, name: country.name);
                        //  states = await Services().widget.loadStates(c);
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      itemBuilder: (country) {
                        return Row(
                          children: <Widget>[
                            picker.CountryPickerUtils.getDefaultFlagImage(
                                country),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Expanded(child: Text('${country.name}')),
                          ],
                        );
                      }),
                ),
              )
      );
  Widget renderStateInput() {
    if (states.isNotEmpty) {
      var items = <DropdownMenuItem>[];
      states.forEach((item) {
        items.add(
          DropdownMenuItem(
            child: Text(item.name),
            value: item.id,
          ),
        );
      });
      String value;
      if (states.firstWhere((o) => o.id == address.state, orElse: () => null) !=
          null) {
        value = address.state;
      }
      return DropdownButton(
        items: items,
        value: value,
        onChanged: (val) {
          setState(() {
            address.state = val;
          });
        },
        isExpanded: true,
        itemHeight: 70,
        hint: Text(S.of(context).stateProvince),
      );
    } else {
      return TextFormField(
        controller: _stateController,
        validator: (val) {
          return val.isEmpty ? S.of(context).streetIsRequired : null;
        },
        decoration: InputDecoration(labelText: S.of(context).stateProvince),
        onSaved: (String value) {
          address.state = value;
        },
      );
    }
  }

  Widget renderAreaInput() {
    return TextFormField(
      focusNode: _areaNode,
      controller: _areaController,
      style: Theme.of(context).textTheme.bodyText1,

      // validator: (val) {
      //   return val.isEmpty ? S.of(context).streetIsRequired : null;
      // },
      decoration: InputDecoration(
          labelText: S.of(context).area,
          labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
        fillColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 2.0,
          ),
        ),
      ),
      onSaved: (String value) {
        address.city = null;
        address.area = value;
      },
    );
  }

  Widget renderJadaInput() {
    return TextFormField(
      controller: _jadaController,
      focusNode: _jadaNode,
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_apartmentNode),
      // validator: (val) {
      //   return val.isEmpty ? S.of(context).streetIsRequired : null;
      // },
      decoration: InputDecoration(labelText: S.of(context).jada,
        labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
        fillColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 2.0,
          ),
        ),
      ),
      onSaved: (String value) {
        address.jada = value;
        address.way= address.province=address.governorate= null;
      },
    );
  }

  Widget renderWayInput() {
    return TextFormField(
      focusNode: _wayNode,
      controller: _wayController,

      // validator: (val) {
      //   return val.isEmpty ? S.of(context).streetIsRequired : null;
      // },
      decoration: InputDecoration(labelText: S.of(context).way,
        labelStyle: Theme.of(context).textTheme.headline6.copyWith(color: Colors.black),
        fillColor: Colors.white,
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 2.0,
          ),
        ),

      ),
      onSaved: (String value) {
        address.way = value;
        address.jada= address.province=address.governorate= null;
      },
    );
  }

  Widget renderGovernorateInput() {

    var items = const <DropdownMenuItem>[
      DropdownMenuItem(child:   Text('Capital Governorate'),value: 'Capital Governorate',),
      DropdownMenuItem(child:  Text('Moharraq Governorate'),value: 'Moharraq Governorate',),
      DropdownMenuItem(child:   Text('Northern Governorate'),value: 'Northern Governorate',),
      DropdownMenuItem(child:  Text('Southern Governorate'),value: 'Southern Governorate',)
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const  SizedBox(height: 10,),
        Text('Governorate',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black.withOpacity(0.5),fontSize: 14),),
        DropdownButton(
          focusNode: _governorateNode,
          items: items,
          value:governorate,
          onChanged: (val) {
            setState(() {
              address.governorate = val;
              print(address.governorate);

              governorate = val;
              address.jada= address.province=address.way= null;
            });
          },
          isExpanded: true,
          itemHeight: 70,
          hint: Text(S.of(context).governorate),
        ),
      ],
    );
  }

  Widget renderProvinceInput() {

    var items = const <DropdownMenuItem>[
      DropdownMenuItem(child:   Text('Riyadh'),value: 'Riyadh',),
      DropdownMenuItem(child:  Text('Makkah'),value: 'Makkah',),
      DropdownMenuItem(child:   Text('AlMadinah'),value: 'AlMadinah',),
      DropdownMenuItem(child:  Text('Qasim'),value: 'Qasim',),
      DropdownMenuItem(child:  Text('Jizan'),value: 'Jizan',),
      DropdownMenuItem(child:  Text('AlSharqiyah'),value: 'AlSharqiyah',),
      DropdownMenuItem(child:  Text('Tabuk'),value: 'Tabuk',),
      DropdownMenuItem(child:  Text('Haiyel'),value: 'Haiyel',),
      DropdownMenuItem(child:  Text('AlBaha'),value: 'AlBaha',),
      DropdownMenuItem(child:  Text('AlShamaleyah'),value: 'AlShamaleyah',),
      DropdownMenuItem(child:  Text('Aseer'),value: 'Aseer',),
      DropdownMenuItem(child:  Text('AlJawf'),value: 'AlJawf',),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const  SizedBox(height: 10,),
        Text('Province',style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black.withOpacity(0.5),fontSize: 14),),

        DropdownButton(
          focusNode: _provinceNode,
          items: items,

          value: province,
          onChanged: (val) {
            setState(() {
              address.province = val;
              province = val;
              address.jada= address.governorate=address.way= null;
            });
          },
          isExpanded: true,
          itemHeight: 70,
          hint: Text(S.of(context).province),
        ),
      ],
    );
  }

  Widget renderEmiratesInput() {
    var theme  = Theme.of(context);

    var items = const <DropdownMenuItem>[
      DropdownMenuItem(child:   Text('Dubai'),value: 'Dubai',),
      DropdownMenuItem(child:  Text('Abu Dhabi'),value: 'Abu Dhabi',),
      DropdownMenuItem(child:   Text('Sharjah'),value: 'Sharjah',),
      DropdownMenuItem(child:  Text('Ajman'),value: 'Ajman',),
      DropdownMenuItem(child:  Text('RasAlKhaimah'),value: 'RasAlKhaimah',),
      DropdownMenuItem(child:  Text('Fujairah'),value: 'Fujairah',),
      DropdownMenuItem(child:  Text('Um Qaiwain'),value: 'Um Qaiwain',)
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const  SizedBox(height: 10,),
        Text('Emirate',style: theme.textTheme.caption.copyWith(color: Colors.black,fontSize: 14,),),
        DropdownButton(
          focusNode: _emirateNode,
          items: items,
          value: emirate,
          onChanged: (val) {
            setState(() {
              emirate = val;
              address.emirate = val;
              address.block = null;
            });
          },
          isExpanded: true,
          itemHeight: 70,
          hint: Text(S.of(context).emirates,style: const TextStyle(color: Colors.black),),
        ),
      ],
    );
  }

}






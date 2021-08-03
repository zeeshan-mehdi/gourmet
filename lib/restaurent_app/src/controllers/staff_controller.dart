


import 'package:flutter/material.dart';
import 'package:markets/restaurent_app/src/repository/staff_repository.dart';
import 'package:markets/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/staff_repository.dart' as staffRepo;

class StaffController extends ControllerMVC{


  bool isFetched = false;
  GlobalKey<ScaffoldState> scaffoldKey;

  List<User> users  = [];

  StaffController(){
    scaffoldKey = GlobalKey<ScaffoldState>();
    listenForMarketStaff();
  }


  listenForMarketStaff()async{

    users = await staffRepo.getMarketUsers();
    setState((){ isFetched = true; });
  }

  Future<bool> addNewStaff(String marketId,String email)async {
     setState(() {isFetched = false;});
     return await addStaffUser(marketId,email);
  }


  Future<bool> deleteStaff1(String marketId,String userId)async{
    setState(() {isFetched = false;});
    return await deleteStaff(marketId, userId);

  }


  void refreshKitchens() {
    listenForMarketStaff();
  }

}
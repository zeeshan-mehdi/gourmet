


import 'package:flutter/material.dart';
import 'package:markets/src/models/user.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../repository/staff_repository.dart' as staffRepo;

class StaffController extends ControllerMVC{

  GlobalKey<ScaffoldState> scaffoldKey;

  List<User> users  = [];



  StaffController(){
    scaffoldKey = GlobalKey<ScaffoldState>();
    listenForMarketStaff();
  }


  listenForMarketStaff()async{
    users = await staffRepo.getMarketUsers();

    print('final users received $users');
    setState(() { });
  }

}
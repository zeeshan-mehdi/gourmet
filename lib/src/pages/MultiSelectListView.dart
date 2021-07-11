

import 'package:markets/src/pages/GlobalPopup.dart';
import 'package:multi_select_item/multi_select_item.dart';
import 'package:flutter/material.dart';


// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Multi Select View Item Example',
//       theme: new ThemeData(
//         primarySwatch: Colors.red,
//       ),
//       home: new MultiSelectItemsWidget(),
//     );
//   }
// }

class MultiSelectItemsWidget extends StatefulWidget {
  List mainList;
  MultiSelectItemsWidget({this.mainList});
  @override
  _MultiSelectItemsWidgetState createState() => new _MultiSelectItemsWidgetState(mainList: mainList);
}

class _MultiSelectItemsWidgetState extends State<MultiSelectItemsWidget> {
  //List mainList = new List();
  //List mainList = [{"key":"Top Rated"},{"key" :"Nearest"},{"key": "Cost High to Low"},{"key" :"Most Popular"}];
  List mainList;
  _MultiSelectItemsWidgetState({this.mainList});
  MultiSelectController controller = new MultiSelectController();
  @override
  void initState() {
    super.initState();
    // mainList.add({"key":"Top Rated"});
    // mainList.add({"key" :"Nearest"});
    // mainList.add({"key": "Cost High to Low"});
    // mainList.add({"key" :"Most Popular"});
    controller.disableEditingWhenNoneSelected = true;
    setState(() {

    controller.set(mainList.length);
    });
  }

  // void add() {
  //   mainList.add({"key": mainList.length + 1});
  //
  //   setState(() {
  //     controller.set(mainList.length);
  //   });
  // }
  //
  // void delete() {
  //   var list = controller.selectedIndexes;
  //   list.sort((b, a) =>
  //       a.compareTo(b)); //reoder from biggest number, so it wont error
  //   list.forEach((element) {
  //     mainList.removeAt(element);
  //   });
  //
  //   setState(() {
  //     controller.set(mainList.length);
  //   });
  // }
  // void selectAll() {
  //   setState(() {
  //     controller.toggleAll();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //block app from quitting when selecting
        var before = !controller.isSelecting;
        setState(() {
          controller.deselectAll();
        });
        return before;
      },
      child: new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Selected ${controller.selectedIndexes.length}  ' +
        //       controller.selectedIndexes.toString()),
        //   actions: (controller.isSelecting)
        //       ? <Widget>[
        //     IconButton(
        //       icon: Icon(Icons.select_all),
        //       onPressed: selectAll,
        //     ),
        //     IconButton(
        //       icon: Icon(Icons.delete),
        //       onPressed: delete,
        //     )
        //   ]
        //       : <Widget>[],
        // ),
        body: ListView.builder(
          itemCount: mainList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: MultiSelectItem(
                isSelecting: controller.isSelecting,
                onSelected: () {
                  setState(() {
                    controller.toggle(index);
                  });
                },
                child: Container(
                  child: Container(
                    height: 40,
                   // contentPadding: EdgeInsets.all(0.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("${mainList[index]['key']}",style: TextStyle(fontSize: 16),),
                            Spacer(),
                            controller.isSelected(index)?  Icon(
                              Icons.check,
                              color: Colors.orange,

                            ): SizedBox(),
                          ],
                        ),
                         Divider(color: Colors.grey,),
                      ],
                    ),
                //    title:


                  ),
                  decoration: controller.isSelected(index)
                      ? new BoxDecoration(color: Colors.transparent)
                      : new BoxDecoration(),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
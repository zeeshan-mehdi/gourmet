
import 'package:flutter/material.dart';
class ProfileKitchenSection extends StatefulWidget {
  @override
  _ProfileKitchenSectionState createState() => _ProfileKitchenSectionState();
}

class _ProfileKitchenSectionState extends State<ProfileKitchenSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.red
                  ),
                ),
                SizedBox(width: 20,),
                Text('Manage Restaurant',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black,fontSize: 20),),

              ],
            ),


            IconButton(icon: Icon(Icons.arrow_forward_ios_outlined),color: Colors.black.withOpacity(0.5), onPressed: (){})

          ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blue
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Manage Restaurant',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black,fontSize: 20),),

                ],
              ),
            IconButton(icon: Icon(Icons.arrow_forward_ios_outlined),color: Colors.black.withOpacity(0.5), onPressed: (){})

          ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Manage Restaurant',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black,fontSize: 26),),

                ],
              ),
            IconButton(icon: Icon(Icons.arrow_forward_ios_outlined),color: Colors.black.withOpacity(0.5), onPressed: (){})

          ],),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.red
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text('Manage Restaurant',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black,fontSize: 26),),

                ],
              ),
            IconButton(icon: Icon(Icons.arrow_forward_ios_outlined),color: Colors.black.withOpacity(0.5), onPressed: (){})

          ],),
        ],
      ),
    );
  }
}

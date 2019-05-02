import 'package:flutter/material.dart';

class ClassInfo extends StatefulWidget{
  String className;

  ClassInfo(this.className);

  @override
  State<StatefulWidget> createState() {
    return ClassInfoState(this.className);
  }

}

class ClassInfoState extends State<ClassInfo> {
  String className;
  ClassInfoState(this.className);

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(className),
        ),

        body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                // First element
                new Text("Professor: Emilia Paz")
                // Second element

              ],

            )
        )
    );
  }


}
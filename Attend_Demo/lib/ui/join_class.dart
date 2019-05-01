import 'package:flutter/material.dart';

class JoinClass extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return JoinClassState();
  }

}

class JoinClassState extends State<JoinClass> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Class'),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // First element

            // Second element
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Colors.amber[400],
                      textColor: Colors.white,
                      child: Text(
                        'Join',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Save button clicked");
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),


                ],
              ),
            ),




          ],

        )
      )
    );
  }
}

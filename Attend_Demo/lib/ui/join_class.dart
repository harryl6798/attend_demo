import 'package:flutter/material.dart';
import 'dart:async';

class JoinClass extends StatefulWidget{
  JoinClass({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return JoinClassState();
  }

}

class JoinClassState extends State<JoinClass>with TickerProviderStateMixin {
  int _state = 0;
  Animation _animation;
  AnimationController _controller;
  GlobalKey _globalKey = GlobalKey();
  double _width = double.maxFinite;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  Widget build(BuildContext context){
    return Scaffold(
        resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Join Class'),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: new Container(
            padding: const EdgeInsets.all(30.0),
            color: Colors.white,
            child: new Container(
              child: new Center(
                  child: new Column(
                      children : [
                        new Padding(padding: EdgeInsets.only(top: 20.0)),

                        new Text('Enter Class Number',
                          style: new TextStyle(color: Colors.blueAccent, fontSize: 25.0),),

                        new Padding(padding: EdgeInsets.only(top: 15.0)),
                        new TextFormField(
                          decoration: new InputDecoration(
                            labelText: "Enter Number",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                              ),
                            ),
                            //fillColor: Colors.green
                          ),

                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                        new Padding(padding: EdgeInsets.only(top: 20.0)),

                        new PhysicalModel(
                elevation: 8,
                shadowColor: Colors.lightGreenAccent,
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  key: _globalKey,
                  height: 48,
                  width: _width,
                  child: RaisedButton(
                    animationDuration: Duration(milliseconds: 1000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.all(0),
                    child: setUpButtonChild(),
                    onPressed: () {
                      setState(() {
                        if (_state == 0) {
                          animateButton();
                        }
                      });

                    },
                    elevation: 4,
                    color: Colors.lightGreen,
                  ),
                ),
              ),


                      ]
                  ),
              ),
              ),
            )

        )

    );
  }
  setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "Click Here",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      );
    } else if (_state == 1) {
      return SizedBox(
        height: 36,
        width: 36,
        child: CircularProgressIndicator(
          value: null,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  void animateButton() {
    double initialWidth = _globalKey.currentContext.size.width;

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48) * _animation.value);
        });
      });
    _controller.forward();

    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
        Navigator.pop(context);

      });
    });
  }
}


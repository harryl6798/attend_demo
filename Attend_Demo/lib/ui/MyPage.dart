import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import './join_class.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Bottom Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'circular_bottom_navigation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPos = 0;

  double bottomNavBarHeight = 60;

  List<TabItem> tabItems = List.of([
    new TabItem(Icons.home, "Home", Colors.cyan[300]),
//    new TabItem(Icons.layers, "Reports", Colors.red),
    new TabItem(Icons.settings, "Settings", Colors.cyan[600]),
  ]);

  CircularBottomNavigationController _navigationController;

  @override
  void initState() {
    super.initState();
    _navigationController = new CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(child: bodyContainer(), padding: EdgeInsets.only(bottom: bottomNavBarHeight),),
          Align(alignment: Alignment.bottomCenter, child: bottomNav()),
          Align(alignment: Alignment.topCenter, child: topNav())

        ],
      ),
    );
  }

  Widget bodyContainer() {
    Color selectedColor = tabItems[selectedPos].color;
    Widget thing;
    Widget thingButton;

    final titles = ['EECS 168', 'MATH 125', 'ENGL 101'];

    final icons = [Icons.code, Icons.functions,
    Icons.border_color ];
    switch (selectedPos) {
      case 0:
          thingButton = new FloatingActionButton(
            onPressed: (){
              debugPrint('button pressed');
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return JoinClass();
              }));
            },
            backgroundColor: Colors.amber[400],
            //if you set mini to true then it will make your floating button small
            mini: false,
            child: new Icon(Icons.add),
          );

          thing = new ListView.builder(
            //physics: FixedExtentScrollPhysics(),
            itemCount: titles.length,
            itemBuilder: (context, index) {

              return Card( //
                //                         <-- Card widget
                child: ListTile(
                  leading: Icon(icons[index]),
                  title: Text(titles[index]),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: ()
                    {print('wow');},
                ),
              );
            },
          );

        break;
//      case 1:
////        slogan = "Find, Check, Use";
//        thing = null;
//        break;
      case 1:
//        slogan = "Receive, Review, Rip";
        thingButton = null;
        thing = null;

        break;
    }

    return new Scaffold(
        floatingActionButton: thingButton,
        body: new Container(
        width: double.infinity,
        height: double.infinity,
        color: selectedColor,
        padding: new EdgeInsets.all(32.0),
        child: thing
      ),
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      barHeight: bottomNavBarHeight,
      barBackgroundColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int selectedPos) {
        setState(() {
          this.selectedPos = selectedPos;
          print(_navigationController.value);
        });
      },
    );
  }


  Widget topNav() {
    return Banner(
      message: "",
      location: BannerLocation.topStart,
    );
  }


  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:table_calendar/table_calendar.dart';
import './join_class.dart';
import './class_info.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import './login_page.dart';

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

  Material MyItems(IconData icon, String heading, int color){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // 1. Text
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(heading,
                          style:TextStyle(
                            color: new Color(color),
                            fontSize: 20.0,
                          )),
                    ),
                  ),

                  // 2. Icon
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: new Icon(icon),
                        color: Colors.white,
                        iconSize: 30.0,
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        )
      ),
    );
  }

  Material MyItemsLogout(IconData icon, String heading, int color){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // 1. Text
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(heading,
                            style:TextStyle(
                              color: new Color(color),
                              fontSize: 20.0,
                            )),
                      ),
                    ),

                    // 2. Icon
                    Material(
                      color: new Color(color),
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: new Icon(icon),
                          color: Colors.white,
                          iconSize: 30.0,
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoginPage(),)),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          )
      ),
    );
  }

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
    Widget header;

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

          thing = new Container(
              width: double.infinity,
              height: double.infinity,
              color: selectedColor,
              padding: new EdgeInsets.all(32.0),
              child: new ListView.builder(
                //physics: FixedExtentScrollPhysics(),
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return Card( //
                    child: ListTile(
                      leading: Icon(icons[index]),
                      title: Text(titles[index]),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: (){
                        debugPrint('button class pressed');
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ClassInfo(titles[index]);
                        }));
                      },
                    ),
                  );
                },
              )
          );

        break;


      // SETTINGS
      case 1:

        thingButton = null;
        thing = new Container(
          margin: const EdgeInsets.symmetric(vertical: 200.0),
          child: new StaggeredGridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
            children: <Widget>[
              MyItems(Icons.person,"Edit Profile",4280731354),
              MyItems(Icons.security,"Privacy",4280731354),
              MyItems(Icons.email,"Contact",4280731354),
              MyItemsLogout(Icons.keyboard_backspace,"Logout",4280731354),
            ],
            staggeredTiles: [
              StaggeredTile.extent(1,150),
              StaggeredTile.extent(1,150),
              StaggeredTile.extent(1,150),
              StaggeredTile.extent(1,150),
            ],
          )
        );


        break;
    }

    return new Scaffold(
        floatingActionButton: thingButton,
        body: thing,
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
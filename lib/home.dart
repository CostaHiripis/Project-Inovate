import 'package:CheckOff/timerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'calendarpage.dart';
import 'timerpage.dart';
import 'testpage.dart';

//This is the root container for the entire screen, it accepts StfWidg
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

//This is the class in which you can initialize widgets
class _MainScreenState extends State<MainScreen> {
  
  //List of pages to be displayed in a swipeable manner
  List<Widget> pages = [CalendarPage(), TimerPage(), TestPage()];
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//Push test
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(),
      ),
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            child: Center(
              child: TestPage(),
            ),
          ),
          CalendarPage(),
          Container(
              child: Center(
            child: TimerPage(),
          )),
        ],
      ),
    );
  }
}

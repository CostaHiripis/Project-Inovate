import 'package:CheckOff/services/auth.dart';
import 'package:CheckOff/signout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendarpage.dart';
import 'login.dart';
import 'notificationsPage.dart';
import 'services/rating.dart';
import 'signout.dart';

void main() => runApp(App());

/// This Widget is the main application widget.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.blue),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: LoginScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _auth = new AuthService();
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    CalendarPage(),
    NotificationsPage(),
    Rating(),
    // SignoutScreen(),
  ];
  void _onItemTapped(int index) {
    if (index == 3) {
      setState(() {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit this application?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () async {
                  _auth.signOut();
                  CalendarPage calendarPage = CalendarPage();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Yes'),
              ),
            ],
          ),
        );
      });
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.lightBlue,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Colors.white70,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.white70))),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                title: Text('Calendar'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                title: Text('Ratings'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.all_out),
                title: Text('Signout'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            selectedFontSize: 16,
            onTap: _onItemTapped,
          ),
        ));
  }
}
//

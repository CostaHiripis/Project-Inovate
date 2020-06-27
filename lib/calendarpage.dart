import 'package:CheckOff/notificationsPage.dart';
import 'package:CheckOff/services/auth.dart';
import 'package:CheckOff/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:table_calendar/table_calendar.dart";
import 'notificationsPage.dart';

final DatabaseService _databaseService = DatabaseService();

//This is the root container for the entire screen, it accepts StfWidg
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

//This is the class in which you can initialize widgets
class _CalendarPageState extends State<CalendarPage> {

  NotificationsPage notificationsPage = new NotificationsPage();

  final DatabaseService _dbServices = DatabaseService();
  final AuthService _auth = AuthService();
  static bool alreadyLoaded = false;

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    notificationsPage.initializing();
    _controller = CalendarController();
    _eventController = TextEditingController();
//    _eventDescriptionController = TextEditingController();

    // This code is suppose to get all the
    Future<void> getUserEvents() async {
      //We look for user with email that was given in login form
      if (alreadyLoaded == false) {
        final CollectionReference userAssignments =
            Firestore.instance.collection('userAssignments');
        FirebaseUser user = await FirebaseAuth.instance.currentUser();

        userAssignments
            .where("userEmail", isEqualTo: user.email)
            .snapshots()
            .listen((data) => data.documents.forEach((doc) {
                  DateTime eventDay = doc["eventDay"].toDate();

                  //We format date to string and we get only Year,Month and day
                  var formater = new DateFormat('yyyy-MM-dd');
                  String formatted = formater.format(eventDay);
                  String taskName = doc["taskName"];
                  print('$formatted + $taskName');
                }));
        alreadyLoaded = true;
      }
    }

    _selectedEvents = [];
    _events = {};
    // _selectedEventsDescription = [];
    // _finalEventList = {..._events, ..._eventDescriptions};
    getUserEvents();
  }

//This is the place in which all the widgets displayed are customized

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //This creates a box that sorrounds the calendar and makes it scrollable
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              events: _events,
              //Set the calendar controler parameter
              calendarController: _controller,
              //Set the starting day of the week to monday
              startingDayOfWeek: StartingDayOfWeek.monday,
              //Set default calendar format to week
              initialCalendarFormat: CalendarFormat.week,
              onDaySelected: (day, events) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              //Start defining the calendar style
              calendarStyle: CalendarStyle(
                todayColor: Colors.green,
                selectedColor: Colors.blue,
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                //Hide the formatter for week/month
                formatButtonShowsNext: false,
                formatButtonVisible: false,
                centerHeaderTitle: true,
              ),
            ),
            // ..._finalEventList.map((event, description) => SingleChildScrollView(
            //       scrollDirection: Axis.vertical,
            //       child: Column(
            //         children: <Widget>[
            //           Card(
            //               child: ListTile(
            //             onTap: () {},
            //             title: Text(event),

            //             subtitle: Text(event),

            //             leading: Icon(Icons.assignment_turned_in),
            //             trailing: Icon(Icons.more_vert),
            //           ))
            //         ],
            //       ),
            //     ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () {
              _showAddDialog();
          }
      ),
    );
  }

  _showAddDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Creating new event:"),
              content: Container(
                constraints: BoxConstraints(
                  //Alert box min height without cause conflicts with the checkbox
                  maxHeight: 155,
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Event name"),
                      controller: _eventController,
                    ),
                    addForm()
                  ],
                ),
              ),
              //Save button widget
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () async {
                    setState(() async {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                      } else {
                        //Create the event and push it to the database
                        dynamic result = await _auth.createAnEvent(
                            _eventController.text,
                            DateTime.now(),
                            _controller.selectedDay);
                        // print(_controller.selectedDay);

                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                      }
                      _eventController.clear();
                      Navigator.pop(context);
                    });
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: Navigator.of(context).pop,
                )
              ],
            ),
    );
  }
}
// ignore: camel_case_types
class addForm extends StatefulWidget{
  @override
  addCheckAndDrop createState()=> new addCheckAndDrop();
}

class addCheckAndDrop extends State<addForm>{
  String _currentItem = '1 hour';
  bool reminderCheck = false;
  var DropDownItems = ['15 minutes','30 minutes','1 hour','6 hours','1 day'];


  @override
  Widget build(BuildContext context) {
    return     Container(
      child: Column(
        children: <Widget>[
          CheckboxListTile(
            title: Text("Enable reminders"),
            value: reminderCheck,
            onChanged: (bool newValue) {
              setState(() {
                reminderCheck = newValue;
              });
            },
            controlAffinity: ListTileControlAffinity
                .leading, //  <-- leading Checkbox
          ),
          DropdownButton<String>(
            value: _currentItem,
            items: DropDownItems.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _currentItem = newValue;
              });
              print(newValue);
              print(_currentItem);
            },
          ),
        ],
      ),
    );
  }
}

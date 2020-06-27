import 'dart:async';
import 'dart:io';

import 'package:CheckOff/login.dart';
import 'package:CheckOff/notificationsPage.dart';
import 'package:CheckOff/services/auth.dart';
import 'package:CheckOff/services/database.dart';
import 'package:CheckOff/services/rating.dart';
import 'package:CheckOff/testpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import "package:table_calendar/table_calendar.dart";
import 'notificationsPage.dart';

final DatabaseService _databaseService = DatabaseService();
NotificationsPage notificationsPage = new NotificationsPage();
var reminderTimeInSeconds;
String taskName;

//This is the root container for the entire screen, it accepts StfWidg
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

//This is the class in which you can initialize widgets
class _CalendarPageState extends State<CalendarPage> {
  final DatabaseService _dbServices = DatabaseService();
  final AuthService _auth = AuthService();

  //All the variables that we pass to rating constructor
  bool checkIfCompleted;
  String idOfDocument;
  String checkedTaskName;
  String checkedUserEmail;
  Timestamp checkedPostDate;
  Timestamp checkedEventDay;
  String checkedFormattedDay;

  //This List stores all found tasks while conducting a getUserEvents()
  List<String> tasks = new List<String>();

  final _formKey = GlobalKey<FormState>();
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  List<dynamic> _selectedEvents;

  // This code is suppose to get all the
  Future<void> getUserEvents() async {
    //We get Collection of 'userAssignments' from database
    final CollectionReference userAssignments =
        Firestore.instance.collection('userAssignments');

    //We get current logged in user
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //This is used to format a DateTime of selected day to String 'yyyy-MM-dd'
    var formater = new DateFormat('yyyy-MM-dd');
    String formatted = formater.format(_controller.selectedDay);

    //We get rid off a all the unneded data from list
    tasks.clear();

    //This is a query, We loop through entire collection and we look for a document
    // with email of logged in user and we look for a day that is
    // equal to selected formated day (variable formatted)

    userAssignments
        .where("userEmail", isEqualTo: user.email)
        .where("eventDayForCalendar", isEqualTo: formatted)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              // DateTime eventDay = doc["eventDay"].toDate();
              // String formatted = formater.format(eventDay);

              // We get a taskName from that document and we add it to our local List tasks
              String taskName = doc["taskName"];

              tasks.add(taskName);
            }));
  }

  Future<void> checkIfAssignmentWasCompleted(String taskName) async {
//We get Collection of 'userAssignments' from database
    final CollectionReference userAssignments =
        Firestore.instance.collection('userAssignments');

    //We get current logged in user
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    //This is used to format a DateTime of selected day to String 'yyyy-MM-dd'
    var formater = new DateFormat('yyyy-MM-dd');
    checkedFormattedDay = formater.format(_controller.selectedDay);

    //This is a query, We loop through entire collection and we look for a document
    // with email of logged in user and we look for a day that is
    // equal to selected formated day (variable formatted)

    userAssignments
        .where("userEmail", isEqualTo: user.email)
        .where("eventDayForCalendar", isEqualTo: checkedFormattedDay)
        .where("taskName", isEqualTo: taskName)
        .snapshots()
        .listen((data) => data.documents.forEach((doc) {
              checkIfCompleted = doc["completed"];
              idOfDocument = doc["documentID"];
              checkedTaskName = doc['taskName'];
              checkedUserEmail = doc['userEmail'];
              checkedPostDate = doc['postDate'];
              checkedEventDay = doc['eventDay'];
              checkedFormattedDay = doc['eventDayForCalendar'];
            }));
  }

  @override
  void initState() {
    super.initState();
    notificationsPage.initializing();
    _controller = CalendarController();
    _eventController = TextEditingController();
//    _eventDescriptionController = TextEditingController();

    _selectedEvents = [];
    _events = {};
    // _selectedEventsDescription = [];
    // _finalEventList = {..._events, ..._eventDescriptions};
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
              onDaySelected: (day, events) async {
                await getUserEvents();

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
            Column(
                children: tasks
                    .map((i) => new Card(
                            child: ListTile(
                          title: Text(i.toString()),
                          onTap: () async {
                            await checkIfAssignmentWasCompleted(i.toString());
                            Timer(Duration(seconds: 1), () async {
                              if (checkIfCompleted == false) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                        'Do you want to mark it as completed?'),
                                    actions: <Widget>[
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No'),
                                      ),
                                      FlatButton(
                                        onPressed: () async {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Rating(
                                                      passedDayOfEvent:
                                                          checkedFormattedDay,
                                                      documentID: idOfDocument,
                                                      taskName: checkedTaskName,
                                                      userEmail:
                                                          checkedUserEmail,
                                                      eventDay: checkedEventDay,
                                                      postDate: checkedPostDate,
                                                    )),
                                            (Route<dynamic> route) => false,
                                          );
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TestPage()),
                                  (Route<dynamic> route) => true,
                                );
                              }
                            });
                          },
                          leading: Icon(Icons.assignment_turned_in),
                        )))
                    .toList())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showAddDialog();
          }),
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
            maxHeight: 185,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _eventController,
                  validator: (val) =>
                      val.isEmpty ? 'Enter an event name' : null,
                  decoration: InputDecoration(
                    hintText: "Event name",
                  ),
                ),
                addForm()
              ],
            ),
          ),
        ),
        //Save button widget
        actions: <Widget>[
          FlatButton(
            child: Text("Save"),
            onPressed: () async {
              setState(() async {
                if (_formKey.currentState.validate()) {
                  if (_events[_controller.selectedDay] != null) {
                    _events[_controller.selectedDay].add(_eventController.text);
                    notificationsPage.secondsTillNotification =
                        reminderTimeInSeconds;
                    notificationsPage.showNotification(
                        'You got work to do', _eventController.text);
                  } else {
                    //Create the event and push it to the database
                    dynamic result = await _auth.createAnEvent(
                        _eventController.text,
                        DateTime.now(),
                        _controller.selectedDay);

                    _events[_controller.selectedDay] = [_eventController.text];
                  }
                  _eventController.clear();
                  Navigator.pop(context);
                }
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
class addForm extends StatefulWidget {
  @override
  addCheckAndDrop createState() => new addCheckAndDrop();
}

class addCheckAndDrop extends State<addForm> {
  String _currentItem = '1 hour';
  bool reminderCheck = false;
  var DropDownItems = [
    '15 minutes',
    '30 minutes',
    '1 hour',
    '6 hours',
    '1 day'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
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
            controlAffinity:
                ListTileControlAffinity.leading, //  <-- leading Checkbox
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

                switch (_currentItem) {
                  case '15 minutes':
                    reminderTimeInSeconds = 900;
                    break;
                  case '30 minutes':
                    reminderTimeInSeconds = 1800;
                    break;
                  case '1 hour':
                    reminderTimeInSeconds = 3600;
                    break;
                  case '6 hours':
                    reminderTimeInSeconds = 21600;
                    break;
                  case '1 day':
                    reminderTimeInSeconds = 86400;
                    break;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

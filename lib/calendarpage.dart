import 'package:CheckOff/notificationsPage.dart';
import 'package:CheckOff/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:table_calendar/table_calendar.dart";
import 'notificationsPage.dart';
import 'package:CheckOff/services/database.dart';

final DatabaseService _databaseService = DatabaseService();
final DbSearch _dbSearch = DbSearch();

//This is the root container for the entire screen, it accepts StfWidg
class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

//This is the class in which you can initialize widgets
class _CalendarPageState extends State<CalendarPage> {
  NotificationsPage notifications = new NotificationsPage();

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  List<dynamic> _selectedEvents;
  final AuthService _auth = AuthService();
  bool reminderCheck = false;

  void _reminderCheckChanged(bool newValue) => setState(() {
        reminderCheck = newValue;

        if (reminderCheck) {
          // TODO: enable reminders.
        } else {
          // TODO: disable reminders
        }
      });

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _selectedEvents = [];
    // _selectedEventsDescription = [];
    // _finalEventList = {..._events, ..._eventDescriptions};
    _events = {};
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
        onPressed: _showAddDialog,
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
                  maxHeight: 104,
                ),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(hintText: "Event name"),
                      controller: _eventController,
                    ),
                    //Reminder checkbox
                    CheckboxListTile(
                      title: Text("Enable reminders"),
                      value: reminderCheck,
                      onChanged: _reminderCheckChanged,
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                  ],
                ),
              ),
              //Save button widget
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () async {
                    if (_eventController.text.isEmpty) return;
                    setState(() async {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                        addNotifications(_eventController.text);
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
                )
              ],
            ));
  }
}

import 'package:CheckOff/notificationsPage.dart';
import 'package:CheckOff/timerpage.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import "package:table_calendar/table_calendar.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'timerpage.dart';
import 'notificationsPage.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _selectedEvents = [];
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
                centerHeaderTitle: false,
              ),
            ),
            ..._selectedEvents.map((event) => SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: <Widget>[
                      Card(
                          child: ListTile(
                        onTap: () {},
                        title: Text(event),
                        leading: Icon(Icons.assignment_turned_in),
                        trailing: Icon(Icons.more_vert),
                      ))
                    ],
                  ),
                ))
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
              content: TextField(
                controller: _eventController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                        addNotifications(_eventController.text);
                      } else {
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

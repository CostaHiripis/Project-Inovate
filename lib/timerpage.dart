import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}
class _TimerPageState extends State<TimerPage> {

bool isVisible = false;
bool running = false;
String buttonStartStopResume = "Start";
String stopTimeToDisplay = "00:00:00";
var sWatch = Stopwatch();
final dur = const Duration(seconds: 1);

void startTimer()
{
  Timer(dur, keepRunning);
}

void keepRunning()
{
  if(sWatch.isRunning)
  {
    startTimer();
  }
  setState(() {
     stopTimeToDisplay = sWatch.elapsed.inHours.toString().padLeft(2, "0") + ":" + 
  (sWatch.elapsed.inMinutes%60).toString().padLeft(2, "0") + ":" + 
  (sWatch.elapsed.inSeconds%60).toString().padLeft(2, "0");
  });
 
}

void startStopwatch()
{
  sWatch.start();
  startTimer();
}

void stopStopwatch()
{
  sWatch.stop();
}

void resetStopwatch()
{
  sWatch.reset();
  stopTimeToDisplay = "00:00:00";
}


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  stopTimeToDisplay,
                  style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            '$buttonStartStopResume',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: running ? Colors.red : Colors.green,
                          onPressed: () {
                            try {
                              if (running == false && buttonStartStopResume == "Start") {
                                setState(() {
                                  running = true;
                                  buttonStartStopResume = "Stop";
                                  startStopwatch();
                                });
                              } else if (running == true && buttonStartStopResume == "Stop") {
                                setState(() {
                                  running = false;
                                  buttonStartStopResume = "Resume";
                                  stopStopwatch();
                                  isVisible = true;
                                });
                              } else if (running == false && buttonStartStopResume == "Resume") {
                                setState(() {
                                  running = true;
                                  buttonStartStopResume = "Stop";
                                  startStopwatch();
                                });
                              }
                            } on Exception {}
                          },
                        ),
                        Visibility(
                          visible: isVisible,
                          child: 
                        RaisedButton(
                          child: Text(
                            'Reset',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            try {
                              if (running == false && buttonStartStopResume == "Resume") {
                                setState(() {
                                  running = false;
                                  buttonStartStopResume = "Start";
                                  resetStopwatch();
                                  isVisible = false;
                                });
                              }
                            } on Exception {}
                          },
                        ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }
}

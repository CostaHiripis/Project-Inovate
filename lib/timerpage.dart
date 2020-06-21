import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        keepRunning();
        break;

      case AppLifecycleState.resumed:
        keepRunning();
        break;

      case AppLifecycleState.inactive:
        keepRunning();
        break;

      case AppLifecycleState.detached:
        keepRunning();
        break;
    }
  }

  bool isVisible = false;
  bool running = false;
  String buttonStartStopResume = "Start";
  String stopTimeToDisplay = "00:00:00";
  var sWatch = Stopwatch();
  final dur = const Duration(seconds: 1);

  void startTimer() {
    Timer(dur, keepRunning);
  }

  void keepRunning() {
    if (sWatch.isRunning) {
      startTimer();
    }
    setState(() {
      stopTimeToDisplay = sWatch.elapsed.inHours.toString().padLeft(2, "0") +
          ":" +
          (sWatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
          ":" +
          (sWatch.elapsed.inSeconds % 60).toString().padLeft(2, "0");
    });
  }

  void startStopwatch() {
    sWatch.start();
    startTimer();
    setState(() {
      running = true;
      buttonStartStopResume = "Stop";
      isVisible = false;
    });
  }

  void stopStopwatch() {
    sWatch.stop();
    setState(() {
      running = false;
      buttonStartStopResume = "Resume";
      isVisible = true;
    });
  }

  void resetStopwatch() {
    sWatch.reset();
    stopTimeToDisplay = "00:00:00";
    setState(() {
      running = false;
      buttonStartStopResume = "Start";
      isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 20,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                stopTimeToDisplay,
                style: TextStyle(fontSize: 70.0, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 15.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text('$buttonStartStopResume',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        color: running ? Colors.red : Colors.green,
                        onPressed: () {
                          try {
                            if (running == false &&
                                buttonStartStopResume == "Start") {
                              startStopwatch();
                            } else if (running == true &&
                                buttonStartStopResume == "Stop") {
                              stopStopwatch();
                            } else if (running == false &&
                                buttonStartStopResume == "Resume") {
                              startStopwatch();
                            }
                          } on Exception {}
                        },
                      ),
                      Container(
                        width: 5,
                      ), //For the margin between buttons
                      Visibility(
                        visible: isVisible,
                        child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 15.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'Reset',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          color: Colors.blue,
                          onPressed: () {
                            try {
                              if (running == false &&
                                  buttonStartStopResume == "Resume") {
                                resetStopwatch();
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

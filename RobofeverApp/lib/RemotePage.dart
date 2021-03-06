import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:robofever/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:numberpicker/numberpicker.dart';

Cooler device = Cooler();

class Remote extends StatefulWidget {
  static String id = 'RemotePage';
  double scale = 1.15;

  @override
  _RemoteState createState() => _RemoteState();
}

class _RemoteState extends State<Remote> {
  double elevated = 10;
  int Speed = 1;
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
        backgroundColor: Color(0xFF33A4F4),
        title: Center(
          child: Text(
            'RoboFever',
            style: TextStyle(
              fontFamily: 'Orbitron',
              letterSpacing: 2,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Material(
                    type: MaterialType.circle,
                    color: Colors.white,
                    elevation: elevated,
                    shadowColor: elevated == 2 ? kOnShade : kOffShade,
                    child: Center(
                      child: RawMaterialButton(
                        shape: CircleBorder(),
                        elevation: elevated,
                        onPressed: () {
                          if (elevated == 2) {
                            elevated = 10;
                            device.changePump(Status.OFF);
                            device.changeSwing(Status.OFF);
                          } else {
                            elevated = 2;
                            device.changePump(Status.ON);
                            device.changeSwing(Status.ON);
                          }
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Icon(
                            MdiIcons.powerStandby,
                            size: orientation == Orientation.landscape
                                ? size.width * (0.1)
                                : size.height * (0.1),
                            color: elevated == 2 ? kOnShade : kOffShade,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
//            Text('RBCOOL08'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: orientation == Orientation.landscape
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Speed',
                            style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'Ubuntu',
                                fontSize: 20),
                          ),
                        ),
                        Container(
                          height: orientation == Orientation.landscape
                              ? size.width * 0.2 * widget.scale
                              : size.height * 0.2 * widget.scale,
                          width: orientation == Orientation.landscape
                              ? size.height * 0.2 * widget.scale
                              : size.width * 0.2 * widget.scale,
                          child: Material(
                            color: Color(0xFFEAEAEB),
                            borderRadius: BorderRadius.circular(10),
                            type: MaterialType.button,
                            child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (Speed < 3) {
                                        Speed++;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                        width: size.width * 0.2 * widget.scale,
                                        child: Icon(
                                          Icons.add,
                                          size:
                                              size.width * 0.07 * widget.scale,
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      '$Speed',
                                      style: TextStyle(
                                        fontSize:
                                            size.height * 0.035 * widget.scale,
                                        fontFamily: 'Orbitron',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Divider(
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (Speed > 1) {
                                        Speed--;
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      width: size.width * 0.2 * widget.scale,
                                      child: Icon(
                                        Icons.remove,
                                        size: size.width * 0.07 * widget.scale,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  8,
                                  orientation == Orientation.landscape
                                      ? size.width * 0.032
                                      : size.height * 0.032,
                                  0,
                                  0),
                              child: GestureDetector(
                                onTap: () {
                                  if (device.swingState == Status.OFF &&
                                      elevated == 2) {
                                    setState(() {
                                      device.changeSwing(Status.ON);
                                    });
                                  } else {
                                    setState(() {
                                      device.changeSwing(Status.OFF);
                                    });
                                  }
                                },
                                child: ToggleButton(
                                  Setting: 'Swing',
                                  icon: MdiIcons.airPurifier,
                                  State: device.swingState == Status.ON,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0,
                                  orientation == Orientation.landscape
                                      ? size.width * 0.032
                                      : size.height * 0.032,
                                  0,
                                  0),
                              child: GestureDetector(
                                onTap: () {
                                  if (device.waterPumpState == Status.OFF &&
                                      elevated == 2) {
                                    setState(() {
                                      device.changePump(Status.ON);
                                    });
                                  } else {
                                    setState(() {
                                      device.changePump(Status.OFF);
                                    });
                                  }
                                },
                                child: ToggleButton(
                                  Setting: 'Pump',
                                  icon: MdiIcons.waterPump,
                                  State: device.waterPumpState == Status.ON,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Time(
                          icon: MdiIcons.timer,
                          Setting: 'Timer',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ToggleButton extends StatelessWidget {
  IconData icon;
  bool State;
  String Setting;
  double scale = 0.90;
  ToggleButton({this.icon, this.Setting, this.State});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: orientation == Orientation.landscape
            ? size.width * 0.11 * scale
            : size.height * 0.11 * scale,
        width: orientation == Orientation.landscape
            ? size.height * 0.35 * scale
            : size.width * 0.35 * scale,
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(10),
          color: State == true ? kRemoteON : Color(0xFFEAEAEB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: orientation == Orientation.landscape
                      ? size.height * 0.12 * scale
                      : size.width * 0.12 * scale,
                  color: State == true ? Colors.white : Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Setting,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.017 * scale
                                : size.height * 0.017 * scale,
                            color:
                                State == true ? Colors.white : kLightTextColor),
                      ),
                      Text(
                        State == true ? 'ON' : 'OFF',
                        style: TextStyle(
                            fontFamily: 'Fjalla',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.045 * scale
                                : size.height * 0.045 * scale,
                            color: State == true ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Time extends StatefulWidget {
  IconData icon;
  bool State;
  String Setting;
  double scale = 1;
  int TimeForTimer = device.time;
  String timetoDisplay = '0';

  Time({this.icon, this.Setting});
  @override
  _TimeState createState() => _TimeState();
}

class _TimeState extends State<Time> {
  void call(){
//    setState(() {
      start();
//    });
  }
  void start(){
    widget.TimeForTimer = device.time;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if(widget.TimeForTimer < 1 || device.timerState == Status.OFF){
          t.cancel();
          setState(() {
            device.changeTimer(Status.OFF, device.time = 0);
          });
        }else{
          if(widget.TimeForTimer < 60){
            widget.timetoDisplay = widget.TimeForTimer.toString();
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }else if(widget.TimeForTimer < 3600){
            int m = widget.TimeForTimer~/60;
            int s = widget.TimeForTimer - (60*m);
            if(m < 10){
              widget.timetoDisplay ='0:0'+m.toString();
            }else{
              widget.timetoDisplay ='0:'+m.toString();
            }
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }else{
            int h = widget.TimeForTimer ~/3600;
            int t = widget.TimeForTimer - (h*3600);
            int m = t ~/60;
            int s = t - (60*m);
            if(m<10){
              widget.timetoDisplay = h.toString()+':0'+m.toString();
            }else{
              widget.timetoDisplay = h.toString()+':'+m.toString()+':'+s.toString();
            }
            widget.TimeForTimer = widget.TimeForTimer - 1;
          }
        }
        print(widget.TimeForTimer);
      });
    });

  }

  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
      child: Container(
//        height: orientation == Orientation.landscape
//            ? size.width * 0.2 * widget.scale
//            : size.height * 0.2 * widget.scale,
        width: orientation == Orientation.landscape
            ? size.height * 0.5 * widget.scale
            : size.width * 0.65 * widget.scale,
        child: Material(
          type: MaterialType.button,
          borderRadius: BorderRadius.circular(10),
          color: device.timerState == Status.ON ? kRemoteON : Color(0xFFEAEAEB),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  widget.icon,
                  size: orientation == Orientation.landscape
                      ? size.height * 0.12 * widget.scale
                      : size.width * 0.12 * widget.scale,
                  color: device.timerState == Status.ON ? Colors.white : Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.Setting,
                        style: TextStyle(
                            fontFamily: 'Ubuntu',
                            fontSize: orientation == Orientation.landscape
                                ? size.width * 0.017 * widget.scale
                                : size.height * 0.017 * widget.scale,
                            color:
                                device.timerState == Status.ON ? Colors.white : kLightTextColor),
                      ),
                      (device.time != null)
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${widget.timetoDisplay}',style: TextStyle(color: Colors.white,fontFamily: 'Ubuntu',fontSize: 25,fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: size.width*0.15,
                          ),
                          Padding(
//                        left: 70.0,
//                        bottom: 30,
                            padding: EdgeInsets.fromLTRB(size.width*0.01, 0.0, 0.0, size.width*0.08),
                            child: FlutterSwitch(
                              width: orientation == Orientation.landscape? size.height*0.2:size.width*0.2,
                              height: orientation == Orientation.landscape? size.height*0.1:size.width*0.1,
                              inactiveColor: Colors.deepOrange,
                              activeColor: Colors.greenAccent,
                              activeTextColor: Colors.black54,
                              valueFontSize: orientation == Orientation.landscape? size.height*0.04:size.width*0.04,
                              toggleSize: 30.0,
                              value: device.timerState == Status.ON,
                              borderRadius: 30.0,
                              padding: 8.0,
                              showOnOff: true,
                              onToggle: (val) {
                                setState(() {
                                  if(val == true){
                                    device.changeTimer(Status.OFF,null);
                                  }
                                  else{
                                    device.changeTimer(Status.OFF, 0);
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )
                          : TimerButton(call: call,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimerButton extends StatefulWidget {
  int hour = 0;
  int min = 0;
  int sec = 0;
  final VoidCallback call;
  TimerButton({this.call});
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
//                      height: 100,
                      child: NumberPicker.integer(
                        listViewWidth: 60,
                        initialValue: widget.hour,
                        minValue: 0,
                        maxValue: 24,
                        onChanged: (val) {
                          setState(() {
                            widget.hour = val;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Text('Hrs'),
                Column(
                  children: [
                    Container(
//                      height: 100,
                      child: NumberPicker.integer(
                        listViewWidth: 60,
                        initialValue: widget.min,
                        minValue: 0,
                        maxValue: 60,
                        onChanged: (val) {
                          setState(() {
                            widget.min = val;
                          });
                        },
                      ),
                    )
                  ],
                ),
                Text('Min'),
              ],
            ),
            GestureDetector(
                onTap: () {
                  device.changeTimer(
                      Status.ON, ((widget.hour * 60 * 60) + (widget.min * 60)));
                  widget.call();
                  print(device.time);
                },
                child: Material(
                  type: MaterialType.button,
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Start Timer',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

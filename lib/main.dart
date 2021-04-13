import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(home: MyApp(),));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _location="location here";

  @override
  void initState() {
    super.initState();

    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      setState(() {
        _location=location.coords.latitude.toString()+'|'+location.coords.longitude.toString();
      });
     // print('[location] - $location');
      Fluttertoast.showToast(
          msg: '[location] - $location',
          toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.CENTER,
          // timeInSecForIosWeb: 1,
          // backgroundColor: Colors.red,
          // textColor: Colors.white,
          fontSize: 16.0
      );

    });



    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
        locationAuthorizationRequest: 'Always',
        backgroundPermissionRationale: bg.PermissionRationale(
            title: "Allow access to this device's location in the background?",
            message: "In order to allow X, Y and Z in the background, please enable 'Allow all the time' permission",
            positiveAction: "Change to Allow all the time",
            negativeAction: "Cancel"
        ),

        notification: bg.Notification(
        title: "cockatoo",
        text: "we are running "
      ),
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(_location, style: TextStyle(fontSize: 30)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

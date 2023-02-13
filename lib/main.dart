

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fba/Controllers/FamillyMembersProvider.dart';
import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Route.dart';
import 'package:fba/Screens/LiveShare/LiveShare.dart';
import 'package:fba/Screens/SplashScreen/SplashScreen.dart';
import 'package:fba/Screens/LiveShare/LiveShareNEWTry.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'DefaultFirebaseOptions.dart';
import 'Wrapper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';


 List<CameraDescription> _cameras = <CameraDescription>[];
final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setup() async {
  // #1
  const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSetting = IOSInitializationSettings();

  // #2
  const initSettings =
  InitializationSettings(android: androidSetting, iOS: iosSetting);

  // #3
  await _localNotificationsPlugin.initialize(initSettings).then((_) {
    debugPrint('setupPlugin: setup success');
  }).catchError((Object error) {
    debugPrint('Error: $error');
  });
}

Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    );
    Workmanager().registerOneOffTask("task-identifier", "simpleTask");
    // add these lines
    await setup();

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    _logError(e.code, e.description);
  }




  runApp( MyApp());
}
@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: backgroundTask"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//
//     // initialise the plugin of flutterlocalnotifications.
//     FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();
//
//     // app_icon needs to be a added as a drawable
//     // resource to the Android head project.
//     var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
//     var IOS = new IOSInitializationSettings();
//
//     // initialise settings for both Android and iOS device.
//     var settings = new InitializationSettings(android: android, iOS: IOS);
//     flip.initialize(settings);
//     CollectionReference reference = FirebaseFirestore.instance.collection('notification');
//     reference.snapshots().listen((querySnapshot) {
//       querySnapshot.docChanges.forEach((snapshot) {
//         Map<String, dynamic> data = snapshot.doc!.data() as Map<String, dynamic>;
//         print(data['listonotified']);
//         _showNotificationWithDefaultSound(flip ,data['listonotified']);
//         // Do something with change
//       });
//     });
//
//
//     return Future.value(true);
//   });
// }

Future _showNotificationWithDefaultSound(flip,message) async {

  // Show a notification after every 15 minute with the first
  // appearance happening a minute after invoking the method
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.high,
      priority: Priority.high
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

  // initialise channel platform for both Android and iOS device.
  var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
  );
  await flip.show(0, 'FBA notification',
      message,
      platformChannelSpecifics, payload: 'Default_Sound'
  );
}

void _logError(String code, String? message) {
  if (message != null) {
    print('Error: $code\nError Message: $message');
  } else {
    print('Error: $code');
  }
}



class MyApp extends StatelessWidget {

  SendData sendData = SendData();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return   StreamProvider<List<dynamic>>(
      create: (_) => sendData.getThemAll(context),
      initialData: const [],
      catchError: (_, error) => [

      ],
      child:

          MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              routes: routes,
              theme: ThemeData(
                fontFamily: 'LibreFranklin-Black',
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primarySwatch: Colors.blue,
              ),
              home:
             // LiveShareNEWTry()
              SafeArea(child: Wrapper())
          )

    );
  }
}

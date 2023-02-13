import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/FetchContactScreen/FetchContactScreeen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../constants.dart';
import '../../size_config.dart';

import '../SignInScreen/SignInScreen.dart';

class AddHome extends StatefulWidget {
  const AddHome({Key? key}) : super(key: key);

  @override
  State<AddHome> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<AddHome> {
  Position? _currentPosition;
  SendData sendData = SendData();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "",
      lat = "";
  late StreamSubscription<Position> positionStream;

  //  final picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String address = "null";
  String autocompletePlace = "null";

  final TextEditingController _controller = TextEditingController();

  bool isLoading = false;

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    print("ok fffff");
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("ok fffff");
    print("osama fffffffff" +
        position.longitude.toString()); //Output: 80.24599079
    print("osama" + position.latitude.toString()); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  var token;

  showAlert(text, context) {
    showDialog(
      context: context,
      builder: (ctx) =>
          AlertDialog(
            title: const Text("Error"),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Container(
                  color: pressed,
                  padding: const EdgeInsets.all(14),
                  child: const Text("okay"),
                ),
              ),
            ],
          ),
    );
  }

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder<String>(
            future: sendData.getToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                token = snapshot.data;
                if (snapshot.data != 'failed') {
                  return Container(
                    decoration: const BoxDecoration(color: primaryColor),
                    width: double.infinity,
                    child: isLoading ? loadingInterface(context) :
                    ListView(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // IconButton(onPressed: (){
                              //   Navigator.pop(context);
                              // }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.screenWidth * 0.04),
                                child:const Text(
                                  "Add your Home",
                                    style: TextStyle(
                                        color: lightGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Container(
                          height: SizeConfig.screenHeight -
                              SizeConfig.screenHeight * 0.1,
                          decoration: const BoxDecoration(
                              color: whightbg,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.02,
                                horizontal: SizeConfig.screenHeight * 0.05),
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.screenHeight * 0.01),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: const [
                                      Text("Home",
                                          style: TextStyle(
                                            color: primaryColor,
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.screenHeight * 0.01),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: const [
                                      Text("Add the location of your Home",
                                          style: TextStyle(
                                            color: darkGrey,
                                          )),
                                    ],
                                  ),
                                ),

                                ///temporary
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10)),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    // width: SizeConfig.screenWidth * 0.5,

                                      height: SizeConfig.screenHeight * 0.5,
                                      child: const Image(
                                        image: AssetImage('assets/img/map.jpg'),
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10)),
                                Container(
                                  width: SizeConfig.screenWidth * 0.5,
                                  height: SizeConfig.screenHeight * 0.07,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: yellow,
                                        shape: StadiumBorder()),
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      var data = {
                                        "token":
                                        token,
                                        "latitude": lat,
                                        "longitude": long
                                      };
                                      sendData.setLocation(data).then((value) {
                                        if (value == 'success') {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FetchContact()));
                                        }else {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          SnackBar snakMessage = SnackBar(content: Container(
                                            color: Colors.red,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                  Text("Operation failed"),
                                                Icon(Icons.sms_failed_outlined)
                                              ],
                                            ),
                                          ));

                                          ScaffoldMessenger.of(context).showSnackBar(snakMessage);




                                        }
                                      });


                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             FetchContact()));
                                    },
                                    child: const Text("Save",
                                        style: TextStyle(
                                          color: primaryColor,
                                        )),
                                  ),
                                ),
                                // Container(
                                //     alignment: Alignment.center,
                                //     padding: EdgeInsets.all(50),
                                //     child: Column(children: [
                                //       Text(servicestatus
                                //           ? "GPS is Enabled"
                                //           : "GPS is disabled."),
                                //       Text(haspermission
                                //           ? "GPS is Enabled"
                                //           : "GPS is disabled."),
                                //       Text("Longitude: $long",
                                //           style: TextStyle(fontSize: 20)),
                                //       Text(
                                //         "Latitude: $lat",
                                //         style: TextStyle(fontSize: 20),
                                //       )
                                //     ])),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: SizeConfig.screenWidth * 0.02),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SignInScreen();
                }
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

}

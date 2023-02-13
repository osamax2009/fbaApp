import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:fba/Wrapper.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SetRadius  extends StatefulWidget {
  static String routeName  = 'setRadius';

  const SetRadius({Key? key}) : super(key: key);

  @override
  State<SetRadius> createState() => _SetRadiusState();
}

class _SetRadiusState extends State<SetRadius> {
  bool isLoading = false ;
  var phone ;
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  double _volumeValue = 50;

  void onVolumeChanged(double value) {
    setState(() {
      _volumeValue = value;
    });
  }

  Widget _getRadialGauge() {
    return SfRadialGauge(
        axes: <RadialAxis>[RadialAxis(
            minimum: 0,
            maximum: 100,
            showLabels: false,
            showTicks: false,
            radiusFactor: 0.9,
            axisLineStyle: AxisLineStyle(
                cornerStyle: CornerStyle.bothCurve,
                color: Colors.black12,
                thickness: 10),
            pointers: <GaugePointer>[
              RangePointer(
                  value: _volumeValue,
                  cornerStyle: CornerStyle.bothCurve,
                  width: 10,
                  sizeUnit: GaugeSizeUnit.logicalPixel,
                  color: primaryColor,
              ),
              MarkerPointer(
                  value: _volumeValue,
                  enableDragging: true,
                  onValueChanged: onVolumeChanged,
                  markerHeight: 34,
                  markerWidth: 34,
                  markerType: MarkerType.circle,
                  color: yellow,
                  borderWidth: 2,
                  borderColor: Colors.white54)
            ],
            annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  angle: 90,
                  axisValue: 5,
                  positionFactor: 0.1,
                  widget: Text(_volumeValue.ceil()
                      .toString() + 'Km',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight
                              .bold,
                          color: yellow))
              )
            ]
        )
        ]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false ,
      body: isLoading ? CircularProgressIndicator(): Container(
        decoration: const BoxDecoration(color: primaryColor),
        width: double.infinity,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:  [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
                const Text("Set Radius",
                  style: TextStyle(
                      color: lightGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.screenHeight * 0.05),
              child: const Image(
                image: AssetImage("assets/img/Logo.png"),
              ),
            ),
            Container(
              height: SizeConfig.screenHeight * 0.55,
              decoration: const BoxDecoration(
                  color: whightbg,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.02, horizontal: SizeConfig.screenHeight * 0.05),
                  child: Column(children: [

                    SizedBox(
                      height: SizeConfig.screenHeight * 0.3,
                      child: Center(
                        child: _getRadialGauge() ,

                      ),
                    ),

                    Padding(padding:  EdgeInsets.symmetric(vertical:SizeConfig.screenWidth * 0.02 ),),
                    Container(
                      width: SizeConfig.screenWidth *0.5,
                      height: SizeConfig.screenHeight *0.07,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary:  pressed,
                            shape: StadiumBorder()
                        ),
                        onPressed: (){
                         /// done later
                          Navigator.pop(context);

                        }, child: const Text("Save",style: TextStyle(
                        color: primaryColor,

                      )),),
                    )


                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

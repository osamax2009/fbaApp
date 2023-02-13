import 'dart:developer';
import 'dart:io'; // for File
import 'package:fba/Controllers/SendData.dart';
import 'package:fba/Controllers/UserInformationController.dart';
import 'package:fba/Screens/SignUpScreen/SignUpScreen.dart';
import 'package:flutter/material.dart';

import '../../Controllers/User.dart';
import '../../Models/OtpModel.dart';
import '../../constants.dart';
import '../../size_config.dart';
import 'package:image_picker/image_picker.dart';

import '../AddHome/AddHome.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool agree = false;
  XFile? image; //this is the state variable
  String? imageFilePath;
  //  final picker = ImagePicker();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  _getFromCamera() async {
    final ImagePicker _picker = ImagePicker();
    final img = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = img;
    });
  }
  SendData service = SendData();
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController con_password = TextEditingController();
bool isLoading = false ;

  @override
  Widget build(BuildContext context) {
    //print(phonenumber);




    return FutureBuilder<String>(
      future: service.getToken() ,
      builder: (context,AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {

          print("data from the snapshoot  ${snapshot.data}");
          if (snapshot.data == 'failed') {
            return returnRegisteredScreen( context);
          }else {
            return returnProfileScreen( context);
          }
        }else{
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }

  SafeArea returnRegisteredScreen( BuildContext context) {
    final phonenumber  = ModalRoute.of(context)!.settings.arguments as String;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: isLoading ? Center(child: CircularProgressIndicator(),):Container(
            decoration: const BoxDecoration(color: primaryColor),
            width: double.infinity,
            child: ListView(
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
                        child: Text("Register",
                            style: TextStyle(
                                color: lightGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.02,
                ),
                Container(
                  height: SizeConfig.screenHeight - SizeConfig.screenHeight * 0.1,
                  decoration: const BoxDecoration(
                      color: whightbg,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Form(
                    key: formKey,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Lets now Started",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("all information are required",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 115,
                            width: 115,
                            child: (image != null)
                                ? Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(image!.path)),
                                        backgroundColor: lightGrey,
                                      ),
                                      Positioned(
                                        right: -16,
                                        bottom: 0,
                                        child: SizedBox(
                                          height: 46,
                                          width: 46,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                primary: Colors.white,
                                                backgroundColor:
                                                    Color(0xFFF5F6F9),
                                              ),
                                              onPressed: () {
                                                _getFromCamera();
                                              },
                                              child: const Icon(
                                                Icons.camera_alt_sharp,
                                                color: Colors.black,
                                              )
                                              //SvgPicture.asset("assets/icons/Camera Icon.svg"),
                                              ),
                                        ),
                                      )
                                    ],
                                  )
                                : Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png"),
                                        backgroundColor: lightGrey,
                                      ),
                                      Positioned(
                                        right: -16,
                                        bottom: 0,
                                        child: SizedBox(
                                          height: 46,
                                          width: 46,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  side: BorderSide(
                                                      color: Colors.white),
                                                ),
                                                primary: Colors.white,
                                                backgroundColor:
                                                    Color(0xFFF5F6F9),
                                              ),
                                              onPressed: () {
                                                _getFromCamera();
                                              },
                                              child: const Icon(
                                                Icons.camera_alt_sharp,
                                                color: Colors.black,
                                              )
                                              //SvgPicture.asset("assets/icons/Camera Icon.svg"),
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("First Name",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          TextField(
                            controller: first,
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenHeight * 0.02),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: whightbg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Last Name",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          TextField(
                            controller: last,
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenHeight * 0.02),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: whightbg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Email ",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          TextField(
                            controller: email,
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenHeight * 0.02),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: whightbg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("City",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          TextField(
                            controller: city,
                            obscureText: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenHeight * 0.02),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: whightbg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("password",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenHeight * 0.02),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: whightbg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("confirm password",
                                    style: TextStyle(
                                      color: darkGrey,
                                    )),
                              ],
                            ),
                          ),
                          TextField(
                            controller: con_password,
                            obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenHeight * 0.02),
                              filled: true,
                              fillColor: lightGrey,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(color: whightbg),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                          ),
                          Row(
                            children: [
                              Material(
                                child: Checkbox(
                                  value: agree,
                                  onChanged: (value) {
                                    setState(() {
                                      agree = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                'Agree to our terms and conditions',
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenHeight * 0.01),
                          ),
                          Container(
                            width: SizeConfig.screenWidth * 0.5,
                            height: SizeConfig.screenHeight * 0.07,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: yellow, shape: StadiumBorder()),
                               onPressed: () {
                                 setState(() {
                                   isLoading = true;
                                 });

                                ///temporary
                                 SendData sendData = SendData();

                                   if (image!= null) {

                                                                         sendData
                                            .storeImage(image!.path)
                                            .then((imagepath) async {
                                                                          if (imagepath != 'Failed') {
                                           print('oamsa'+imagepath);
                                            imageFilePath = imagepath;
                                            if (first.text.isNotEmpty
                                            &&
                                                last.text.isNotEmpty &&
                                                email.text.isNotEmpty &&
                                                password.text.isNotEmpty &&
                                                password.text == con_password.text&& agree
                                            ) {
                                            var  data =  {
                                                "phone":phonenumber,
                                                "password":password.text,
                                                "email":email.text,
                                                "name": first.text+ " "+ last.text,
                                                "city": city.text,
                                                "profileimage": "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png"

                                              };
                                            sendData.Register(data).then((value) {

                                                 if (value=='success') {
                                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddHome()));
                                                 }else {
                                                   sendData.showAlert('Failed to register with your information!!!!', context);
                                                   setState(() {
                                                     isLoading = false;
                                                   });
                                                 }

                                            } );
                                            } else {
                                              SendData sendData = SendData();
                                              sendData.showAlert('something wrong with your information', context);
                                                 }
                                                                          }
                                                                          else if(imagepath.containt('failed')){
                                                                            setState(() {
                                                                              isLoading = false ;
                                                                            });
                                                                                ScaffoldMessenger.of(context).showSnackBar(
                                                                                  SnackBar(content: Text(imagepath), backgroundColor: Colors.yellow,)
                                                                                );
                                                                          }
                                                                          else {
                                           SendData sendData = SendData();
                                           sendData.showAlert('profile image not uploaded check your internet', context);
                                           setState(() {
                                             isLoading = false;
                                           });
                                                                          }
                                                                        });
                                   } else {
                                             if (first.text.isNotEmpty
                                                 &&
                                                 last.text.isNotEmpty &&
                                                 email.text.isNotEmpty &&
                                                 password.text.isNotEmpty &&
                                                 password.text == con_password.text&& agree
                                             ) {
                                              var  data =  {
                                                "phone":phonenumber,
                                                "password":password.text,
                                                "email":email.text,
                                                "name": first.text+ " "+ last.text,
                                                "city": city.text,
                                                "profileimage": "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png"

                                              };
                                              sendData.Register(data).then((value) {

                                                if (value=='success') {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddHome()));
                                                }else {
                                                  sendData.showAlert('Failed to register with your information!!!!', context);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                }

                                              } );

                                            }else {
                                               SendData sendData = SendData();
                                               sendData.showAlert('something wrong with your information', context);
                                               setState(() {
                                                 isLoading = false;
                                               });
                                             }
                                   }
                              },
                              child: const Text("Sign In",
                                  style: TextStyle(
                                    color: primaryColor,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.screenWidth * 0.02),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
  SafeArea returnProfileScreen( BuildContext context) {
    print("this is isis $isLoadingUserInfo");
    UserInformationController userInformationController = UserInformationController();
    return SafeArea(
      child: Scaffold(

        resizeToAvoidBottomInset: false,
        body:  isLoading ? Center(child: CircularProgressIndicator(),):
        FutureBuilder<User?>(
          future:userInformationController.getUserInfo() ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return isLoadingUserInfo ?


               const   Center(child:  Text("Updating the User Info."))
              :Container(
                decoration: const BoxDecoration(color: primaryColor),
                width: double.infinity,
                child: ListView(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon:const Icon(Icons.arrow_back_ios,color: lightGrey  ,)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.screenWidth * 0.2),
                            child: const Text("User Profile",
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
                      height: SizeConfig.screenHeight - SizeConfig.screenHeight * 0.1,
                      decoration: const BoxDecoration(
                          color: whightbg,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Form(
                        key: formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.screenHeight * 0.02,
                              horizontal: SizeConfig.screenHeight * 0.05),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.02),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text("you can update your profile",
                                        style: TextStyle(
                                          color: primaryColor,
                                        )),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 115,
                                width: 115,
                                child: (image != null)
                                    ? Stack(
                                  fit: StackFit.expand,
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                      FileImage(File(image!.path)),
                                      backgroundColor: lightGrey,
                                    ),
                                    Positioned(
                                      right: -16,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 46,
                                        width: 46,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                side: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              primary: Colors.white,
                                              backgroundColor:
                                              Color(0xFFF5F6F9),
                                            ),
                                            onPressed: () {
                                              _getFromCamera();
                                            },
                                            child: const Icon(
                                              Icons.camera_alt_sharp,
                                              color: Colors.black,
                                            )
                                          //SvgPicture.asset("assets/icons/Camera Icon.svg"),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                                    : Stack(
                                  fit: StackFit.expand,
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          snapshot.data!.profileimage!),
                                      backgroundColor: lightGrey,
                                    ),
                                    Positioned(
                                      right: -16,
                                      bottom: 0,
                                      child: SizedBox(
                                        height: 46,
                                        width: 46,
                                        child: TextButton(
                                            style: TextButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                side: const BorderSide(
                                                    color: Colors.white),
                                              ),
                                              primary: Colors.white,
                                              backgroundColor:
                                              Color(0xFFF5F6F9),
                                            ),
                                            onPressed: () {
                                              _getFromCamera();
                                            },
                                            child: const Icon(
                                              Icons.camera_alt_sharp,
                                              color: Colors.black,
                                            )
                                          //SvgPicture.asset("assets/icons/Camera Icon.svg"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("First Name",
                                        style: TextStyle(
                                          color: darkGrey,
                                        )
                                    ),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: first,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: snapshot.data!.name!.indexOf(" ") != null?  snapshot.data!.name!.substring(0, snapshot.data!.name!.indexOf(" ")):"",
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenHeight * 0.02),
                                  filled: true,
                                  fillColor: lightGrey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: whightbg),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Last Name",
                                        style: TextStyle(
                                          color: darkGrey,
                                        )),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: last,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText:  snapshot.data!.name!.indexOf(" ") != null?  snapshot.data!.name!.substring(snapshot.data!.name!.indexOf(" "),snapshot.data!.name!.length ):"",
            contentPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenHeight * 0.02),
                                  filled: true,
                                  fillColor: lightGrey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: whightbg),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Email ",
                                        style: TextStyle(
                                          color: darkGrey,
                                        )),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: email,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: snapshot.data!.email,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenHeight * 0.02),
                                  filled: true,
                                  fillColor: lightGrey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: whightbg),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("City",
                                        style: TextStyle(
                                          color: darkGrey,
                                        )),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: city,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: snapshot.data!.city,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenHeight * 0.02),
                                  filled: true,
                                  fillColor: lightGrey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: whightbg),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("old password",
                                        style: TextStyle(
                                          color: darkGrey,
                                        )),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenHeight * 0.02),
                                  filled: true,
                                  fillColor: lightGrey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: whightbg),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("New password",
                                        style: TextStyle(
                                          color: darkGrey,
                                        )),
                                  ],
                                ),
                              ),
                              TextField(
                                controller: con_password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenHeight * 0.02),
                                  filled: true,
                                  fillColor: lightGrey,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(color: whightbg),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenHeight * 0.01),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.5,
                                height: SizeConfig.screenHeight * 0.07,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: yellow, shape: StadiumBorder()),
                                  onPressed: () {
                                    checkifupdatesecuss(snapshot.data!);





                                  },
                                  child: const Text("Update Profile",
                                      style: TextStyle(
                                        color: primaryColor,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.screenWidth * 0.02),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            else {
            return Center(child: const Text("Waiting for the server...."));
            }
          }


           ) ,
        )




    );
  }


  Future<String> updateUserData(User snapshot) async {

    SendData send = SendData();
    var token ;
    await send.getToken().then((value)=>
      token = value
    );
    var firstnameformsnap =snapshot.name!.indexOf(" ")!=  null  ?  snapshot.name!.substring(0,snapshot.name!.indexOf(" ")) : "";
    var lastnameformsnap = snapshot.name!.indexOf(" ")!=  null  ? snapshot.name!.substring(snapshot.name!.indexOf(" "),snapshot.name!.length ) : "";

    var data = {
      'token':token,
      'phone':snapshot.phone,
      'name' : "${first.text.isNotEmpty ?first.text : firstnameformsnap  } ${last.text.isNotEmpty ?last.text : lastnameformsnap }",
      'email': email.text.isNotEmpty? email.text : snapshot.email,
      'city': city.text.isNotEmpty? city.text : snapshot.city,
      'password': '123123123',
    };

    print("data is $data");
    var state ;
  await  send.updateuserinfo(data).then((value) =>
        state = value
        );
    return state ;
  }
  Future<void> checkifupdatesecuss(User snapshot)async {
    setState(() {
      isLoadingUserInfo = true;
    });
  await  updateUserData(snapshot).then(
            (value) {
          if (value == 'success') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const RegisterScreen())
            );
          } else {
            print("our state is $value");
            setState(() {
              isLoadingUserInfo = false;
            });
            const snackBar = SnackBar(
              content: Text('Something Wrong!!'),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
    );
  }
  bool  isLoadingUserInfo = false ;

}



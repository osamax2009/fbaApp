import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Controllers/SendData.dart';
import '../../constants.dart';
import '../../size_config.dart';

class CupForm extends StatelessWidget {
  const CupForm({
    Key? key,
 required   this.press
  }) : super(key: key);
final  Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight -
          SizeConfig.screenHeight * 0.3,
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
          child: Form(

            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.screenHeight * 0.02,
                    horizontal: SizeConfig.screenWidth * 0.01),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight * 0.01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Enter Office Name",
                              style: TextStyle(
                                color: darkGrey,
                              )
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14),
                      // controller: first,
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
                          Text("Badge#",
                              style: TextStyle(
                                color: darkGrey,
                              )),
                        ],
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14),
                      // controller: last,
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
                          Text("Police Department Name",
                              style: TextStyle(
                                color: darkGrey,
                              )),
                        ],
                      ),
                    ),
                    TextField(
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14),
                      //  controller: email,
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
                          vertical: SizeConfig.screenHeight * 0.02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Give rating to the officer Behaviour",
                              style: TextStyle(
                                color: darkGrey,
                              )),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingBar.builder(
                          itemSize: 30.0,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 1,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      ],
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.screenHeight * 0.01),
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: darkGrey,
                          fontSize: 14),

                      maxLines: 5,
                      //controller: password,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 12
                        ),
                        hintText: "Comment on the Officers Behavior",
                        contentPadding: EdgeInsets.all(
                            SizeConfig.screenHeight * 0.01),
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
                        onPressed: press,
                        child: const Text("Submit",
                            style: TextStyle(
                              color: primaryColor,
                            )),
                      ),
                    ),

                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
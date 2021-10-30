import 'dart:core';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:syedflutter/verify.dart';
import 'package:url_launcher/url_launcher.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: MyApp()));
}




class MyApp extends StatefulWidget {
  static const url = "http://flutter.dev";
  @override
  State<StatefulWidget> createState() {
    return MyAppstate();
  }
}

class MyAppstate extends State<MyApp> {
  TextEditingController mobileNumber =TextEditingController() ;
  bool valuefirst = false;
  String get _url => 'https://pub.dev/packages/url_launcher';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Stack(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.red,
                        ),
                      ],
                    )),
                Container(
                  color: Colors.transparent,
                  child: Column(children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 80,
                      width: 100,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Center(
                        child: Text(
                          "TAMA "
                          'family',
                          style: TextStyle(
                            decorationColor: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ),
                    Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderOnForeground: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 2.0,
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            const Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 550,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: CountryCodePicker(
                                onChanged: print,
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'IN',
                                favorite: const ['PK', 'FR', "IT"],
                                // optional. Shows only country name and flag
                                showCountryOnly: false,
                                showFlag: true,
                                showDropDownButton: true,

                                // optional. Shows only
                                // country name and flag when popup is closed.
                                showOnlyCountryWhenClosed: true,

                                // optional. aligns the flag and the Text left
                                alignLeft: false,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                                TextField(
                              controller: mobileNumber,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintText: "Mobile Number",
                                focusColor: Colors.red,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  valuefirst = !valuefirst;
                                });
                              },
                              child: Row(children: [
                                Checkbox(
                                    checkColor: Colors.greenAccent,
                                    activeColor: Colors.red,
                                    value: this.valuefirst,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        valuefirst = value!;
                                      });
                                    }),
                                const Text(
                                  "By signing in to this Tama family app,you agree with the ",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 7),
                                ),
                                InkWell(
                                  onTap: _launchURL,
                                  child: const Text(
                                    "Terms and Conditions ",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 7),
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            ElevatedButton(
                                child: const Text('Login'),
                                style: TextButton.styleFrom(
                                  fixedSize: Size(400, 20),
                                  primary: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                                 onPressed: () {
                                  print("neha");
                                  TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 0, end: 0.3),
                                    duration: const Duration(seconds: 1),
                                    builder: (BuildContext context, double size, Widget? child) {
                                      return const CircularProgressIndicator(
                                        color: Colors.blue,
                                      );
                                    });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VerifyPage(mobileNumber.text, "91")
                                      ));

                                }),
                            const SizedBox(
                              height: 30,
                            )
                          ])),
                    )
                  ]),
                ),
              ],
            ))));
  }

  void _launchURL() async {
    if (await canLaunch(_url)) {
      print("Launched");
      await launch(_url);
    } else {
      print('Could not launch $_launchURL()url');
    }
  }
}

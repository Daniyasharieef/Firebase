import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatefulWidget{
  String? mobileNumber;
  String? countryCode;


   VerifyPage(this.mobileNumber,this.countryCode,);

  @override
  State<StatefulWidget> createState() {
    return _VerifyPageState(mobileNumber, countryCode);
  }
}
bool isVerifyPhoneMethodCalled = false;
class _VerifyPageState extends State<VerifyPage>{
  String? mobileNumber;
  String? countryCode;
  _VerifyPageState(this.mobileNumber,this.countryCode);
  TextEditingController otpController = new TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String verificationId;




  @override
  void initstate() {
    otpController = TextEditingController();
    super.initState();
  }

  Future<void> verifyPhone(phoneNo) async {
    print("executing verifyPhone method");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:"+91 9597556606",
        codeAutoRetrievalTimeout: (String verId){
          // const CircularProgressIndicator();
          print("Timed Out");
        },
        codeSent: (String verificationId, [int? forceCodeResend]){
          this.verificationId = verificationId;
          print("Code Sent");
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential){
          print("Verified");
        },
        verificationFailed: (FirebaseAuthException exception){
          print('failed $exception');
        });
  }

  void verifyOTP(String smsCode) async {

    print(smsCode);
    await _firebaseAuth.signInWithCredential(
        PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode
        )).then((value) => print('success ${value.additionalUserInfo!}'))
        .onError((error, stackTrace) => print("Error $error"));
  }
  @override
  Widget build(BuildContext context) {
    print("Circular");
    /// To avoid calling verifyPhone method multiple times on each build
    if(!isVerifyPhoneMethodCalled){
      // const CircularProgressIndicator(
      //   semanticsLabel: 'Linear progress indicator',
      // );
      isVerifyPhoneMethodCalled = true;
      verifyPhone("+916379114746");
    }

    TextEditingController mobileNumber =TextEditingController() ;
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Stack(children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          SizedBox(
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
                    const  SizedBox(
                        height: 100,
                      ),
                      Container(
                        height: 80,
                        width: 100,
                        padding: const EdgeInsets.all(20),
                        decoration:const BoxDecoration(
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
                      const SizedBox(
                        height: 50,
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
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Verification OTP",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  const  SizedBox(height: 20), // Column(children:[
                                    TextField(
                                        controller: otpController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                            hintText: 'Enter OTP')),
                                    const SizedBox(
                                      height: 30,
                                    ),
                              InkWell(
                                  onTap: () {
                                     const CircularProgressIndicator(semanticsLabel: "Loading",);
                                    verifyPhone("phoneNo");
                                  },
                              child: const Text("Resend"),),
                                   const  SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        child: const Text('Login'),
                                        style: TextButton.styleFrom(
                                          primary: Colors.white,
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          print(otpController.text);
                                          verifyOTP(otpController.text);
                                        }),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ])))
                    ]),
                  )
                ]))));
  }

}

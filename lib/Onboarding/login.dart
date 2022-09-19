import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:welkin/Onboarding/authentication.dart';

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final formKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = true;

  String verificationID = "";

  TextEditingController otpController = TextEditingController();

  TextEditingController phoneController = TextEditingController()..text = '+91';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            
                            otpVisibility == true
                                ? TextFormField(
                                  textInputAction: TextInputAction.done,
                                    controller: phoneController,
                                    validator: ((numbervalue) {
                                      if (numbervalue!.length != 13) {
                                        return 'Mobile Number must be of 10 digit';
                                      }
                                      return null;
                                    }),
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Phone Number",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Center(
                                      child: Pinput(
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          if (value!.length != 6) {
                                            return "Enter the 6 digit Otp";
                                          }
                                          return null;
                                        },
                                        length: 6,
                                        controller: otpController,
                                        focusNode: FocusNode(),
                                        separator: const SizedBox(
                                          width: 10,
                                          // height: 30,
                                        ),
                                        showCursor: true,
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                 Text(
                                  
                                  otpVisibility ? "Sign In " : "Verify",
                                  style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w700),
                                ),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                             if (otpVisibility) {
                                            verifyNumber();
                                          } else {
                                            verifyOTP();
                                          }
                                            
                                          });
                                         
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'register');
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text(
                                    'Sign Up',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xff4c505b),
                                        fontSize: 18,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void verifyNumber() async {
    print("first verif id $verificationID");
    auth.verifyPhoneNumber(
      phoneNumber: phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        var snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter the correct details'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navigator.pushNamed(context, 'otp');
        otpVisibility = false;
        verificationID = verificationId;
        setState(() {
          
        });
        print("second verif id $verificationID");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    print("third verif id $verificationID");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value) {
      Navigator.pushNamed(context, 'speechscreen');
      print("You are logged in successfully");
      var snackBar = SnackBar(
        backgroundColor: Colors.green,
        content: Text('Login success'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

       
    });
  }
}

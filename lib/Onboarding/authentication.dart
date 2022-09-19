// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

// class Verify {
//   FirebaseAuth auth = FirebaseAuth.instance;

//   bool otpVisibility = false;

//   String verificationID = "";
  

//   void verifyNumber(
  
//       TextEditingController phoneController, BuildContext context) async {
//         print("first verif id $verificationID");
//     otpVisibility = true;
//     auth.verifyPhoneNumber(
//       phoneNumber: phoneController.text,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential).then((value) {
//           print("You are logged in successfully");
//         });
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e.message);
//         otpVisibility = false;
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         Navigator.pushNamed(context, 'otp');
//         otpVisibility = false;
//         verificationID = verificationId;
//                 print("second verif id $verificationID");

        
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   void verifyOTP(TextEditingController otpController, BuildContext context) async {
//             print("third verif id $verificationID");

//     otpVisibility = true;
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationID, smsCode: otpController.text);

//     await auth.signInWithCredential(credential).then((value) {
//       otpVisibility = false;
//       Navigator.pushNamed(context, 'speechscreen');
//       print("You are logged in successfully");
//     });
//   }
// }

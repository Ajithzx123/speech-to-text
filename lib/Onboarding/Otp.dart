// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pinput/pinput.dart';
// import 'package:welkin/authentication.dart';

// class OtpPage extends StatefulWidget {
//   OtpPage({Key? key}) : super(key: key);

//   @override
//   State<OtpPage> createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   final formKey = GlobalKey<FormState>();

//   TextEditingController otpController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/login.png'), fit: BoxFit.cover),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SafeArea(
//             child: ListView(children: [
//           Padding(
//               padding: EdgeInsets.all(30),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(
//                           height: 110,
//                         ),
//                         const Text(
//                           "Enter the Code",
//                           style: TextStyle(
//                               fontSize: 40,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         const Text(
//                           "Please enter the 6-digit verification code sent to your Phone Number",
//                           style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white),
//                         ),
//                         const SizedBox(
//                           height: 220,
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 5),
//                           child: Center(
//                             child: Pinput(
//                               validator: (value) {
//                                 if (value!.length != 6) {
//                                   return "Enter the 6 digit Otp";
//                                 }
//                                 return null;
//                               },
//                               length: 6,
//                               controller: otpController,
//                               focusNode: FocusNode(),
//                               separator: const SizedBox(
//                                 width: 10,
//                                 // height: 30,
//                               ),
//                               showCursor: true,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         Center(
//                           child: _RegisterButton(
//                             ontap: () {
//                               if (formKey.currentState!.validate()) {
//                                 setState(() {
//                                 verifyOTP(otpController, context);
//                                 });
//                               }
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 7,
//                         ),
//                         // const RegisterDontHaveAccount()
//                       ],
//                     ),
//                   ],
//                 ),
//               ))
//         ])),
//       ),
//     );
//   }
// }

// final defaultPinTheme = PinTheme(
//     width: 30,
//     height: 30,
//     textStyle: const TextStyle(
//         fontSize: 30,
//         color: Color.fromRGBO(70, 69, 66, 1),
//         fontWeight: FontWeight.bold),
//     decoration: BoxDecoration(
//       color: const Color.fromARGB(94, 202, 202, 202),
//       borderRadius: BorderRadius.circular(24),
//     ));

// class _RegisterButton extends StatelessWidget {
//   final VoidCallback ontap;
//   const _RegisterButton({
//     required this.ontap,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Container(
//           height: 60,
//           width: 350,
//           decoration: const BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(40)),
//             gradient: LinearGradient(colors: [
//               Color.fromRGBO(166, 210, 255, 1),
//               Color.fromARGB(255, 0, 139, 225)
//             ]),
//           ),
//           child: Center(
//               child: Verify().otpVisibility == true
//                   ? CircularProgressIndicator()
//                   : Text(
//                       "Submit",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                           fontSize: 20),
//                     ))),
//     );
//   }
  
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postpro/verifycode.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);
  static const String routeName = "/";
  static String verify="";
  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  @override
  Widget build(BuildContext context) {
    TextEditingController email=new TextEditingController();
    TextEditingController pass=new TextEditingController(text: "+91");
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                    height: 200,
                    width: 200,
                    child: Image.asset('images/logo.jpg')),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CLIP',
                        style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'share',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Continue with phone,you get otp via sms\nto verify,Dont share it to anyone!',
                style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),

            Form(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: TextFormField(
                        focusNode: FocusNode(),
                        keyboardType: TextInputType.phone,
                        controller: email,
                        decoration: InputDecoration(
                            filled: true, //<-- SEE HERE
                            fillColor: Colors.white,
                            border: OutlineInputBorder(

                              borderSide: BorderSide(
                                color: Colors.black
                              ),
                                borderRadius: BorderRadius.circular(10)),
                        focusedBorder:OutlineInputBorder(

                            borderSide: BorderSide(
                                color: Colors.black,
                                    width: 1.3
                            ),
                            borderRadius: BorderRadius.circular(10)),



                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top:14,left:5),
                          child: Text("+91",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                        hintText: "Enter phone",

                        prefixStyle: TextStyle(
                          color: Colors.redAccent,

                        )),
                      )),
                  SizedBox(height: 12,),
                  Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              top: 15, bottom: 15, right: 130, left: 130)),
                          backgroundColor: MaterialStateProperty.all(Colors.black87),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async{
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91'+email.text.toString(),
                            verificationCompleted: (PhoneAuthCredential credential) {

                            },
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent: (String verificationId, int? resendToken) {


                              Signin.verify=verificationId;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Verify(),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );




                        },
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Or continue with',
                      style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),


            ),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(top: 20),
            //       //child: Image.asset('assets/gg.png'),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 20),
            //       //child: Image.asset('assets/apple.png'),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 20),
            //       //child: Image.asset('assets/fb.png'),
            //     ),
            //   ],
            // ),

            SizedBox(height: 20,),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //
            //     Center(
            //
            //       child: Padding(
            //
            //         padding: EdgeInsets.only(top: 2),
            //         child: Row(
            //           children: [
            //             Text('Not a user',
            //                 style: GoogleFonts.poppins(fontSize: 15, color: Colors.black)),
            //             TextButton(onPressed:(){
            //               Navigator.of(context).push(
            //                 MaterialPageRoute(
            //                   builder: (context) => const Signup(),
            //                 ),
            //               );
            //             },
            //               child: Text('Signup here',
            //                 style: GoogleFonts.poppins(fontSize: 17, color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }
}
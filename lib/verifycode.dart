import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:postpro/presistant.dart';
import 'package:postpro/signin.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  final FirebaseAuth auth=FirebaseAuth.instance;

  TextEditingController v1=new TextEditingController();
  TextEditingController v2=new TextEditingController();
  TextEditingController v3=new TextEditingController();
  TextEditingController v4=new TextEditingController();
  TextEditingController v5=new TextEditingController();
  TextEditingController v6=new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            child:Column(
              children: [
                SizedBox(height: 30,),
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
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Enter the otp send to 94******42\nto verify code!',
                    style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          SizedBox(
                            width: 48,
                            height: 44,
                            child: TextFormField(
                              onChanged: (value)async{
                                if(value.length==1){
                                  FocusScope.of(context).nextFocus();

                                }
                                if(value.length==0){
                                  FocusScope.of(context).previousFocus();
                                }

                                ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                String? clipboardText = clipboardData!.text;

                                if (clipboardText != null && clipboardText.length == 6) {
                                  v1.text=clipboardText[0];
                                  v2.text=clipboardText[1];
                                  v3.text=clipboardText[2];
                                  v4.text=clipboardText[3];
                                  v5.text=clipboardText[4];
                                  v6.text=clipboardText[5];


                                }

                              },
                              keyboardType: TextInputType.phone,
                              controller: v1,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)) ,
                                  filled: true, //<-- SEE HERE
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  ),
                            ),
                          ),
                          SizedBox(width: 4,),
                          SizedBox(
                            width: 48,
                            height: 44,

                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: v2,
                              onChanged: (value)async{
                                if(value.length==1){
                                  FocusScope.of(context).nextFocus();

                                }
                                if(value.length==0){
                                  FocusScope.of(context).previousFocus();
                                }

                                ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                String? clipboardText = clipboardData!.text;
                                print(clipboardText);
                                if (clipboardText != null && clipboardText.length == 6) {
                                  v1.text=clipboardText[0];
                                  v2.text=clipboardText[1];
                                  v3.text=clipboardText[2];
                                  v4.text=clipboardText[3];
                                  v5.text=clipboardText[4];
                                  v6.text=clipboardText[5];


                                }

                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)) ,
                                filled: true, //<-- SEE HERE
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),SizedBox(width: 4,),
                          SizedBox(
                            width: 48,
                            height: 44,

                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: v3,
                              onChanged: (value)async{
                                if(value.length==1){
                                  FocusScope.of(context).nextFocus();

                                }
                                if(value.length==0){
                                  FocusScope.of(context).previousFocus();
                                }

                                ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                String? clipboardText = clipboardData!.text;
                                print(clipboardText);
                                if (clipboardText != null && clipboardText.length == 6) {
                                  v1.text=clipboardText[0];
                                  v2.text=clipboardText[1];
                                  v3.text=clipboardText[2];
                                  v4.text=clipboardText[3];
                                  v5.text=clipboardText[4];
                                  v6.text=clipboardText[5];


                                }

                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)) ,
                                filled: true, //<-- SEE HERE
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),SizedBox(width: 4,),
                          SizedBox(
                            width: 48,
                            height: 44,
                            child: TextFormField(
                              onChanged: (value)async{
                                if(value.length==1){
                                  FocusScope.of(context).nextFocus();

                                }
                                if(value.length==0){
                                  FocusScope.of(context).previousFocus();
                                }

                                ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                String? clipboardText = clipboardData!.text;
                                print(clipboardText);
                                if (clipboardText != null && clipboardText.length == 6) {
                                  v1.text=clipboardText[0];
                                  v2.text=clipboardText[1];
                                  v3.text=clipboardText[2];
                                  v4.text=clipboardText[3];
                                  v5.text=clipboardText[4];
                                  v6.text=clipboardText[5];


                                }

                              },
                              keyboardType: TextInputType.phone,
                              controller: v4,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)) ,
                                filled: true, //<-- SEE HERE
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),SizedBox(width: 4,),
                          SizedBox(
                            width: 48,
                            height: 44,
                            child: TextFormField(
                              onChanged: (value)async{
                                if(value.length==1){
                                  FocusScope.of(context).nextFocus();

                                }
                                if(value.length==0){
                                  FocusScope.of(context).previousFocus();
                                }

                                ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                String? clipboardText = clipboardData!.text;
                                print(clipboardText);
                                if (clipboardText != null && clipboardText.length == 6) {
                                  v1.text=clipboardText[0];
                                  v2.text=clipboardText[1];
                                  v3.text=clipboardText[2];
                                  v4.text=clipboardText[3];
                                  v5.text=clipboardText[4];
                                  v6.text=clipboardText[5];


                                }

                              },

                              keyboardType: TextInputType.phone,
                              controller: v5,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)) ,
                                filled: true, //<-- SEE HERE
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),SizedBox(width: 4,),
                          SizedBox(
                            width: 48,
                            height: 44,
                            child: TextFormField(

                              onChanged: (value)async{
                                if(value.length==1){
                                  FocusScope.of(context).nextFocus();

                                }
                                if(value.length==0){
                                  FocusScope.of(context).previousFocus();
                                }

                                ClipboardData? clipboardData = await Clipboard.getData('text/plain');
                                  String? clipboardText = clipboardData!.text;
                                print(clipboardText);
                                  if (clipboardText != null && clipboardText.length == 6) {
                                    v1.text=clipboardText[0];
                                    v2.text=clipboardText[1];
                                    v3.text=clipboardText[2];
                                    v4.text=clipboardText[3];
                                    v5.text=clipboardText[4];
                                    v6.text=clipboardText[5];


                                  }

                              },
                              keyboardType: TextInputType.phone,
                              controller: v6,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                focusedBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)) ,
                                filled: true, //<-- SEE HERE
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 170,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(

                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                                  padding: MaterialStateProperty.all(EdgeInsets.only(
                                      top: 15, bottom: 15, right: 5, left: 5)),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                ),
                                child: Text(
                                  'resend',
                                  style: TextStyle(color: Colors.black,fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async{


                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: Signin.verify, smsCode: v1.text+v2.text);

                                  // Sign the user in (or link) with the credential
                                  await auth.signInWithCredential(credential);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const Verify(),
                                    ),
                                  );
                                },
                              ),
                            ),SizedBox(width: 15,),
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(

                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                                  padding: MaterialStateProperty.all(EdgeInsets.only(
                                      top: 15, bottom: 15, right: 5, left: 5)),
                                  backgroundColor: MaterialStateProperty.all(Colors.black87),
                                ),
                                child: Text(
                                  'Confirm',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async{
                                  PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: Signin.verify, smsCode: v1.text+v2.text+v3.text+v4.text+v5.text+v6.text);
                                  // Sign the user in (or link) with the credential
                                  await auth.signInWithCredential(credential);
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const MyHomePage1(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )),
                  ],
                ),


              ],
            )
            // Create a PhoneAuthCredential with the code


    ),
        ),
      ),
    );
  }
}

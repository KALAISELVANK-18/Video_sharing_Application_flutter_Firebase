
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:postpro/rec.dart';
import 'package:postpro/signin.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.black54,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Center(
            child: Text('ClipShare',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Icon(Icons.notifications,color: Colors.white,),
          )
        ],

      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        width: 208,
        child: ListView(

          children: [DrawerHeader(child: Center(child: Row(
            children: [
              Text("ClipShare",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
              Container(
                  height: 80,
                  width: 80,
                  child: Image.asset('images/logo.jpg'))
            ],
          ))),
            ListTile(title: TextButton(
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context, screen: const Signin(), settings: RouteSettings(name: Signin.routeName),
                    withNavBar: false
                );

              },
              child: Text("Logout",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:200.0),
        child: Center(
          child: Column(
            children: [
                Container(
                  width: 300,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                      Row(
                        children: [
                          Icon(Icons.video_call_rounded,size: 200,color: Colors.redAccent,),
                        ],
                      ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("You can record and post your videos instantly and see the insights of the video",
    style:GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 14,color: Colors.black))),
                        )

                      ],
                    ),
                  ),
                ),SizedBox(height: 30,),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CameraExampleHome()));
              },child: Center(
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Record video",style:GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 14,color: Colors.white)),

                      ),
                      Icon(Icons.video_collection_rounded,size: 50,color: Colors.white,),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}



class Finish extends StatefulWidget {
  const Finish({super.key});

  @override
  State<Finish> createState() => _FinishState();
}

class _FinishState extends State<Finish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.black54,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Center(
            child: Text('ClipShare',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Icon(Icons.notifications,color: Colors.white,),
          )
        ],

      ),
      drawer: Drawer(
        width: 200,
        child: ListView(
          children: [DrawerHeader(child: Icon(Icons.menu))],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:200.0),
        child: Center(
          child: Column(
            children: [
              Container(
                width: 300,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.video_call_rounded,size: 200,color: Colors.redAccent,),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Your Video has been successfully posted!!",
                            style:GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 14,color: Colors.black))),
                      )

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

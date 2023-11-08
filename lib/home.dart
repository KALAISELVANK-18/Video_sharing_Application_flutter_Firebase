import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:postpro/signin.dart';
import 'package:postpro/verifycode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postpro/videoplayer.dart';
import 'package:video_player/video_player.dart';



import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> ? _initializeVideoPlayerFuture;
  VideoPlayerController? _controller;

  @override
  void initState(){
    _controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/postit-dfc2c.appspot.com/o/oswLPBmeHbPo4r5pooFP0sUjF632%2F2023-06-23%2021%3A51%3A52.915993Z?alt=media&token=69ac4b7e-91c3-480e-8140-d579c651344e');
    _initializeVideoPlayerFuture = _controller?.initialize();
    _controller?.setLooping(true);
    _controller?.setVolume(1.0);
    super.initState();
    super.initState();

    @override
    void dispose() {
      _controller?.dispose();
      super.dispose();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Center(
            child: Text('Profile',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:8.0),
            child: Icon(Icons.notifications),
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
                    withNavBar: false);

              },
              child: Text("Logout",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),)
          ],
        ),
      ),

    backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[




            Padding(

              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: StreamBuilder<QuerySnapshot>(
                stream:FirebaseFirestore.instance.collection("posts").where("uid",isEqualTo: FirebaseAuth.instance.currentUser?.uid).snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasData && snapshot.data!=null){
                    List<DocumentSnapshot>nn=snapshot.data!.docs;
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                        stream:FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.uid).doc("person").snapshots(),
                        builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                        if(snapshot.hasData && snapshot.data!=null){
                        DocumentSnapshot<Object?>? nnn=snapshot.data;

                        return Column(
                          children: [


                        SizedBox(height: 10,),
                        Container(

                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              CircleAvatar(
                                radius:30,
                                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60"),
                              ),
                              Column(
                                children: [

                                  Text(nn.length.toString(),style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black)),
                                  ),SizedBox(height: 8,),Text(
                                    'Posts',
                                    style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black)),
                                  ),

                                ],
                              ),

                              Column(
                                children: [


                                  Text("0",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black)),
                                  ),SizedBox(height: 8,),Text(
                                    'Views',
                                    style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black)),
                                  ),

                                ],
                              ),

                              SizedBox()
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical:9.0),
                              child: Text(
                              nnn!.get("name"),
                                style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),

                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              nnn.get("bio"),
                              style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: 15,color: Colors.black)),

                            ),
                          ],
                        ),SizedBox(height: 10,),
                        GestureDetector(

                          onTap: (){

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: Center(child: Text("Edit Profile",textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 15,color: Colors.black)),
                                            )),
                                          ),

                                        ],
                                      ),
                                      // (frameImage!=null)?frameImage:CircularProgressIndicator()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:13.0,bottom: 10),
                              child: Text(
                                'Posts',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        )]);
                        }

                        else{
                        return SingleChildScrollView();
                        }
                        }),
                        (nn.length==0)?Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("No post found"),
                    ),
                  ):SizedBox(),
                        GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.72,
                            crossAxisCount: 3,
                            mainAxisSpacing: 9,
                            crossAxisSpacing: 3,
                          ),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: nn.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FutureBuilder(
                                future: _initializeVideoPlayerFuture,
                                builder: (context, snapshot){
                                  if(snapshot.connectionState == ConnectionState.done){
                                    return GestureDetector(

                                      onTap: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Videopl(x: nn[index])));
                                      },
                                      child: Container(

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: NetworkImage(

                                                    nn[index]["tum"],
                                                      //"https://images.unsplash.com/photo-1566438480900-0609be27a4be?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60"
                                                  ),
                                                ),
                                        ),
                                        child: Center(
                                          child: Icon(Icons.play_circle,color: Colors.white,),
                                        )
                                      ),
                                    );
                                  } else {

                                    return Center(
                                      child: CircularProgressIndicator(backgroundColor: Colors.blue,
                                      ),
                                    );

                                  }
                                }
                            );
                          },
                            ),
                      ],
                    ),
                  ),
                );}
                else{
                  return CircularProgressIndicator();
                  }}
              ),
            ),
          ],
        ),
      ),
    );
     }
}












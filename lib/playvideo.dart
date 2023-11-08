import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:postpro/signin.dart';
import 'package:postpro/vidstart.dart';
import 'package:video_player/video_player.dart';
import 'package:searchfield/searchfield.dart';
import 'package:geolocator/geolocator.dart';




class Play extends StatefulWidget {
   Play({super.key,required this.controller,required this.video});
  VideoPlayerController? controller;
  XFile? video;

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  final _formKey = GlobalKey<FormState>();
  final videoPlayerKey = GlobalKey();
  TextEditingController x=new TextEditingController();
  TextEditingController y=new TextEditingController();
  List<String> _cato=["entertainment","vlog","education","sports","Travel","Food","Fashion","others"];
  late String loc;
  late String vid="";
  late Image frameImage;
  int indi=-1;
  int post=0;
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<List> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    print(123455);
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var news= await Geolocator.getCurrentPosition();


    List<Placemark> placemarks = await placemarkFromCoordinates(news.latitude, news.longitude);
    return [placemarks.first.locality,placemarks.first.administrativeArea];
  }
  @override
  Widget build(BuildContext context) {
    _determinePosition();
    return Scaffold(
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
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context, screen: const Signin(), settings: RouteSettings(name: Signin.routeName),withNavBar: false);

              },
              child: Text("Logout",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),)
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                //Color.fromARGB(180, 255, 0, 0),

                Color.fromARGB(255,255,0,0),
                Color.fromARGB(198,255,69,0),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),

          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left:5.0),
                        child: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
                      ),
                      Text("Postclip",style: TextStyle(
                        color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(right:5.0),
                        child: Icon(Icons.notifications,color: Colors.white,size: 25,),
                      )
                    ],
                  ),SizedBox(height: 10,),
                  SizedBox(
                    width: 200.0,
                    height: 340.0,
                    // child: (localVideoController == null)
                    //     ? (
                    //     // The captured image on the web contains a network-accessible URL
                    //     // pointing to a location within the browser. It may be displayed
                    //     // either with Image.network or Image.memory after loading the image
                    //     // bytes to memory.
                    //     kIsWeb
                    //         ? Image.network(imageFile!.path)
                    //         : Image.file(File(imageFile!.path)))
                    //     :
                    child:Container(

                      child: Center(
                        child: RepaintBoundary(
                          key:videoPlayerKey,
                          child: AspectRatio(
                              aspectRatio:
                              widget.controller!.value.aspectRatio,
                              child: Container(

                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: VideoPlayer(widget.controller!)))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60.0),
                    child: VideoProgressIndicator(widget.controller!, allowScrubbing:true,colors: VideoProgressColors(playedColor: Colors.white,backgroundColor: Colors.white60),),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: (){
                        print(widget.controller!.value.aspectRatio);

                        setState(() {
                          if(widget.controller!.value.isPlaying)
                            widget.controller!.pause();
                          else
                            widget.controller!.play();
                        });
                      }, icon:Container(

                        child: Icon(
                          (widget.controller!.value.isPlaying)?Icons.pause:Icons.play_circle,color: Colors.white,size: 35,
                        ),
                      ) )

                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 4,),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Container(
                      margin:const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Title",style: TextStyle(
                                color: Colors.white,fontSize: 18
                              ),),
                            ],
                          ),SizedBox(height: 5,),
                          Container(
                            height: 24,
                            child: TextFormField(
                              cursorColor: Colors.grey.withOpacity(0.8),
                              onTapOutside: (PointerDownEvent x){
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              style:
                              TextStyle(fontSize: 14.0, color: Colors.grey.withOpacity(0.8)),
                              controller: x,
                              decoration: InputDecoration(

                                enabledBorder: UnderlineInputBorder(

                                          borderSide: BorderSide(
                                          color: Colors.grey,
                                          width: 0.3
                                          ),
                                          ),
                                focusedBorder: UnderlineInputBorder(

                                  borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 2
                                  ),
                                  ),


                                // hintText: "Title.."
                              ),

                            ),
                          ),SizedBox(height: 18,),
                         FutureBuilder<List>(future: _determinePosition(),builder: (context,AsyncSnapshot<List> snapshot){

                            if(snapshot.hasData && snapshot.data!=null)
                            loc=snapshot.data?[0]+", "+snapshot.data?[1];
                           return Container(
                             decoration: BoxDecoration(
                               // gradient: LinearGradient(
                               //   colors: [Color.fromARGB(255,255,255,255), Color.fromARGB(255,255,255,255)],
                               //   begin: Alignment.bottomLeft,
                               //   end: Alignment.topRight,
                               //
                             color: Colors.black
                             ),

                               child:Row(
                                 children: [
                                   Icon(Icons.location_on,color: Color.fromARGB(200,255, 63, 52),),SizedBox(width: 5,),
                                   (snapshot.data!=null)?Text(snapshot.data?[0]+", "+snapshot.data?[1],style: TextStyle(color: Colors.white),):
                                       Container(width: 10,height: 10,
                                           child: CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0,))
                                 ],
                               ));
                         }),SizedBox(height: 30,),Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Text("Category #",style: TextStyle(
                                  color: Colors.white,fontSize: 18
                              ),),
                           ],
                         ),SizedBox(height: 0,),
                          SizedBox(height: 20,),
                         GridView.builder(
                           physics: NeverScrollableScrollPhysics(),
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                             childAspectRatio: 3.2,
                             crossAxisSpacing: 10,
                         mainAxisSpacing: 10,
                         crossAxisCount: 3),
                           itemCount: _cato.length,
                             shrinkWrap: true,

                             scrollDirection: Axis.vertical,
                             itemBuilder: (context,int ind){
                           return GestureDetector(
                             onTap: (){
                                  if(indi==ind){
                                    indi=-1;
                                  }
                                  else{
                                    indi=ind;
                                  }
                             },
                             child: Container(
                               width: 0,height: 0,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                  color: (ind==indi)?Colors.white:Colors.black12,
                                 border: Border.all(color: (ind==indi)?Colors.black12:Colors.grey)
                               ),
                               child:Center(child: Text(_cato[ind],style: TextStyle(
                                 color: (ind!=indi)?Colors.white:Colors.redAccent
                               ),)),),
                           );
                         }),
                          SizedBox(height: 20,),
                          ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 255, 0, 0))
                         ),
                              onPressed: ()async{
                            if(post==0){
                              post=1;
                            try{
                              final c=DateTime.timestamp();
                            final ref = FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser!.uid).child(c.toString()).child("video");
                           await ref.putFile(File(widget.video!.path), SettableMetadata(contentType: 'video/mp4'));

                            final downloadUrl =await FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser!.uid).child(c.toString()).child("video").getDownloadURL();
                            final String url = downloadUrl.toString();
                            print(url);


                              final completer = Completer<Uint8List>();

                              WidgetsBinding.instance.addPostFrameCallback((_) async {
                                final renderObject = videoPlayerKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
                                final image = await renderObject.toImage();
                                final byteData = await image.toByteData(format: ImageByteFormat.png);
                                completer.complete(byteData!.buffer.asUint8List());
                              });


                              final frameImageBytes = await completer.future;


                              // final cacheManager = DefaultCacheManager();
                              // final fileStream = frameImageBytes.asStream();
                              // final fileInfo = await cacheManager.putFile(
                              //   'cache_image', // Unique identifier for the image
                              //   fileStream,
                              //   fileExtension: '.png', // Specify the file extension
                              // );
                              //
                              // fileInfo.path;

                              final refe = FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser!.uid).child(c.toString()).child("tum");

                              await refe.putData(frameImageBytes,SettableMetadata(contentType: "image/png"));

                              final downloadUrl1 =await FirebaseStorage.instance.ref().child(FirebaseAuth.instance.currentUser!.uid).child(c.toString()).child("tum").getDownloadURL();
                              final String url1 = downloadUrl1.toString();

                            await FirebaseFirestore.instance.collection("posts").add({
                              "time":DateTime.timestamp(),
                              "uid":FirebaseAuth.instance.currentUser!.uid,
                              "title":x.text,
                              "url":url,
                              "tum":url1,
                              "category":_cato[indi],
                              "location":loc,
                              "like":0,
                              "dislike":0,
                              "likearr":[],
                              "dislikearr":[],
                              "viewsarr":[],
                              "views":0
                            });
                              post=2;
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Finish()));
                            } catch (error) {
                              post=0;
                              print(post);
                            print(error);
                            }}



                          }, child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: Text("   post   ",textAlign: TextAlign.center,)),
                                    (post==1)?Container(width: 10,height: 10,
                                        child: CircularProgressIndicator(color: Colors.white,strokeWidth: 3.0,)):SizedBox()
                                  ],
                                ),
                                // (frameImage!=null)?frameImage:CircularProgressIndicator()
                              ],
                            ),
                          ))
                        ],
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );

  }
}

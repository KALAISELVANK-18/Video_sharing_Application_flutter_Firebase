import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:postpro/signin.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Videopl extends StatefulWidget {
   Videopl({super.key,required this.x});

  DocumentSnapshot<Object?> x;

  @override
  State<Videopl> createState() => _VideoplState();
}

class _VideoplState extends State<Videopl> {
  int c=0;
  int e=0;
  Future<void> ? _initializeVideoPlayerFuture;
  VideoPlayerController? _controller;

  @override
  void initState(){
    _controller = VideoPlayerController.network(
       widget.x["url"]

      );
    _initializeVideoPlayerFuture = _controller?.initialize();

    _controller?.setLooping(true);

    _controller?.setVolume(1.0);
    _controller?.play();
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
            child: Text('posted by kalai',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
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
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(context, screen: const Signin(), settings: RouteSettings(name: Signin.routeName),withNavBar: false);

              },
              child: Text("Logout",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),)
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: StreamBuilder<DocumentSnapshot>(
              stream:FirebaseFirestore.instance.collection("posts").doc(widget.x.id).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.hasData){
                  List<DocumentSnapshot?> nn=[snapshot.data];
                  List<dynamic> ee=nn[0]?["likearr"];


                  if(ee.contains(FirebaseAuth.instance.currentUser?.uid)){
                    e=1;

                  }
                  else
                    e=0;

                  List<dynamic> cc=nn[0]?["dislikearr"];

                  if(cc.contains(FirebaseAuth.instance.currentUser?.uid))
                    c=1;
                  else
                    c=0;


                  return Column(
                    children: [

                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage("https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60"),
                                ),
                              ),SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:4.0),
                                    child: Text("Kalai",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14,color: Colors.black)),
                                    ),
                                  ),SizedBox(height: 2,),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,color: Colors.redAccent,),SizedBox(width: 2,),
                                      Text(widget.x["location"],style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14,color: Colors.black)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(

                                decoration:BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.greenAccent.shade200,Colors.greenAccent]
                                  ),
                                  borderRadius: BorderRadius.circular(10),


                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(child: Text(widget.x["category"],style: TextStyle(
                                      color: Colors.white,fontWeight: FontWeight.w500
                                  ),)),
                                ),
                              ),SizedBox(width: 6,),
                              Icon(Icons.more_vert_outlined)

                            ],
                          )
                        ],
                      ),SizedBox(height: 5,),
                      Center(
                        child: SizedBox(
                          width: 250,
                          height: 370.0,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:15),
                        child: Row(

                          children: [
                            // Text("__kalai_18__"),
                            SizedBox(width: 5,),
                            Container(
                                width: MediaQuery.of(context).size.width*0.8,
                                child: RichText(
                                  maxLines: 2,
                                  selectionRegistrar: SelectionContainer.maybeOf(context),
                                  text:TextSpan(text: "__kalai__  ",

                                    children: [TextSpan(
                                      text: widget.x["title"],
                                      style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 16),color:Colors.black),
                                    )],
                                    style: GoogleFonts.siemreap(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))

                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [


                                Row(
                                  children: [
                                    IconButton(
                                      color: (e==0)?Colors.black:Colors.red,
                                      onPressed: () async{
                                        if(e==1){

                                          ee.remove(FirebaseAuth.instance.currentUser?.uid.toString());
                                          await FirebaseFirestore.instance.collection("posts").doc(widget.x.id).update({
                                            "like":nn[0]?["like"]-1,
                                            "likearr":ee
                                          });

                                        }
                                        else{
                                          ee.add(FirebaseAuth.instance.currentUser?.uid.toString());
                                          if(c==1){
                                            cc.remove(FirebaseAuth.instance.currentUser?.uid.toString());
                                            await FirebaseFirestore.instance.collection("posts").doc(widget.x.id).update({
                                              "like":nn[0]?["like"]+1,
                                              "likearr":ee,
                                              "dislikearr":cc,
                                              "dislike":nn[0]?["dislike"]-1
                                            });

                                          }else{
                                            await FirebaseFirestore.instance.collection("posts").doc(widget.x.id).update({
                                              "like":nn[0]?["like"]+1,
                                              "likearr":ee
                                            });
                                          }
                                        }
                                      },
                                      icon: Icon(FontAwesomeIcons.heart),
                                    ),
                                    Text(nn[0]!["like"].toString())
                                  ],
                                ),

                                Row(
                                  children: [
                                    IconButton(
                                      color: (c==0)?Colors.black:Colors.red,

                                      onPressed: () async{

                                        if(c==1){

                                          cc.remove(FirebaseAuth.instance.currentUser?.uid.toString());
                                          await FirebaseFirestore.instance.collection("posts").doc(widget.x.id).update({
                                            "dislike":nn[0]!["dislike"]-1,
                                            "dislikearr":cc
                                          });


                                        }

                                        else{
                                          cc.add(FirebaseAuth.instance.currentUser?.uid.toString());
                                          if(e==1){
                                            ee.remove(FirebaseAuth.instance.currentUser?.uid.toString());
                                            await FirebaseFirestore.instance.collection("posts").doc(widget.x.id).update({
                                              "dislike":nn[0]!["dislike"]+1,
                                              "dislikearr":cc,
                                              "likearr":ee,
                                              "like":nn[0]!["like"]-1
                                            });}
                                          else{
                                            await FirebaseFirestore.instance.collection("posts").doc(widget.x.id).update({
                                              "dislike":nn[0]!["dislike"]+1,
                                              "dislikearr":cc
                                            });
                                          }


                                        }

                                      },
                                      icon: Icon(Icons.thumb_down_alt_rounded),
                                    ),

                                  ],
                                ),




                                IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.shareFromSquare))
                              ],
                            ),
                            Text("${nn[0]!["views"]} views",style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("1 day ago",style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.grey)),
                          ),
                        ],
                      ),
                      SizedBox(height: 15,),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10)
                          ),

                        ),
                      )
                    ],

                  );}
                else{
                  return CircularProgressIndicator();
                }
              }
          ),
        ),
      ),
    );
  }
}

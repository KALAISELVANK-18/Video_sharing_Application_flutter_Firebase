import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:postpro/searchpageview.dart';
import 'package:postpro/signin.dart';
import 'package:postpro/videoplayer.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();
  late String x="a";
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Padding(
          padding: const EdgeInsets.only(right:8.0),
          child: Center(
            child: Text('Explore',style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
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
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(

                    context, screen: const Signin(), settings: RouteSettings(name: Signin.routeName),
                withNavBar: false);

              },
              child: Text("Logout",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black)),
              ),
            ),)
          ],
        ),
      ),
      body: Stack(
        children: [SingleChildScrollView(
          child: Column(
            children: [



              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Padding(

                  padding: const EdgeInsets.only(top: 100),
                  child:Column(
                    children: [

                      StreamBuilder<QuerySnapshot>(
                          stream:FirebaseFirestore.instance.collection("posts").where("category",isGreaterThanOrEqualTo: x).snapshots(),
                          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                            if(snapshot.hasData && snapshot.data!=null){
                              List<DocumentSnapshot>nn=snapshot.data!.docs;
                              print(nn.length);
                              return Column(
                                children: [
                                  (nn.length>0)?Padding(
                                    padding: const EdgeInsets.only(left:14.0,bottom: 10),
                                    child: Row(
                                      children: [
                                        Text("Results",style: GoogleFonts.aBeeZee(textStyle: TextStyle(fontSize: 20,color: Colors.grey)),),
                                      ],
                                    ),
                                  ):SizedBox(),
                                  ListView.builder(

                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: nn.length,
                                    itemBuilder: (BuildContext context, int index) {




                                              return (nn[index]["uid"]!=FirebaseAuth.instance.currentUser?.uid)?Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 30,),
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
                                                                      Text(nn[index]["location"],style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 14,color: Colors.black)),
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
                                                                  child: Center(child: Text(nn[index]["category"],style: TextStyle(
                                                                      color: Colors.white,fontWeight: FontWeight.w500
                                                                  ),)),
                                                                ),
                                                              ),SizedBox(width: 6,)

                                                            ],
                                                          )
                                                        ],
                                                      ),SizedBox(height: 5,),
                                                      GestureDetector(
                                                        onTap: (){
                                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Videoplview(x: nn[index])));
                                                        },
                                                        child: Center(
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                image: NetworkImage(//nn[index]["tum"]
                                                                "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60"

                                                                )
                                                              )
                                                            ),
                                                            width: 250,
                                                            height: 370.0,
                                                            child: Center(
                                                              child: Icon(Icons.play_circle,color: Colors.white,),
                                                            )
                                                          ),
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
                                                                      text: nn[index]["title"],
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

                                                            Text("0 views",style: GoogleFonts.nunitoSans(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black)),
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
                                                      )
                                                    ],

                                                  ),
                                                ),
                                              ):SizedBox();

                                          }
                                      ),
                                ],
                              );
                                }

                            else{
                              return Padding(
                                padding: const EdgeInsets.only(top:200),
                                child: Text("Loding"),
                              );
                            }}
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
          Positioned(
            top: 0,
            left: 0,

            child: Container(
              width: MediaQuery.of(context).size.width,

              decoration: BoxDecoration(
                color: Colors.white,),

              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(

                        controller: _searchController,
                        onChanged: (val){
                          setState(() {

                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          labelText: 'Search by category',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),

                          suffixIcon: IconButton(

                              onPressed: (){
                                setState(() {
                                  x=_searchController.text;
                                });

                              },
                              icon: Icon(Icons.search,size: 25,)),
                          suffixIconColor: Colors.black54,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),

                        ),  cursorColor:Colors.black,

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),],
      ),
    );
  }
}

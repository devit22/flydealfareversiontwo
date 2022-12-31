

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/blogsmodel/BlogList.dart';
import 'package:fly_deal_fare/ui/blog_detail_screen.dart';
import 'package:fly_deal_fare/ui/chat_screen.dart';
import 'package:fly_deal_fare/ui/result_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

class TravelUpdateScreen extends StatefulWidget {
  const TravelUpdateScreen({Key? key}) : super(key: key);

  @override
  State<TravelUpdateScreen> createState() => _TravelUpdateScreenState();
}

class _TravelUpdateScreenState extends State<TravelUpdateScreen> {
 List<BlogList> bloglist = [];
var isdatanotloaded = true;
 @override
  void initState() {
    super.initState();
fetchdata();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Stack(
        children: [
          (isdatanotloaded)? Center(
            child: CircularProgressIndicator(color: Colors.green),
          ): ListView.builder(
              shrinkWrap: true,
              itemCount: bloglist.length,
              itemBuilder: (context, position) {
                return Container(
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Card(
                    elevation: 15.0,
                    shape: RoundedRectangleBorder( //<-- SEE HERE
                      side: BorderSide(
                        color: Colors.greenAccent,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          height: Diamensions.height145*2,
                          width: MediaQuery.of(context).size.width,
                          foregroundDecoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("${bloglist[position].image}"),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Container(
                          padding:EdgeInsets.symmetric(horizontal: Diamensions.width5,vertical: Diamensions.height5),
                          child: Text(
                              "${bloglist[position].title}",
                            style: TextStyle(
                              fontSize: Diamensions.fontsize17
                            ),
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: Diamensions.width10,vertical: Diamensions.height5),
                          child: FloatingActionButton.extended(
                            heroTag: "$position",
                              onPressed: (){
                            String urlselected = bloglist[position].link.toString();

                            Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(blogUrl: urlselected,)));
                          }, label: Text("Read More...")
                          ),
                        )


                      ],
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  void fetchdata()  async{
    UserApiService.getblogs().then((value) => {
      bloglist.addAll(value),
      setState(() {
        isdatanotloaded= false;
      })
    });
  }
}

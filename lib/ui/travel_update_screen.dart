

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
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(vertical: Diamensions.width10,horizontal: Diamensions.width10+Diamensions.width5),
                  child: Material(

                    elevation: Diamensions.width10,
                    borderRadius: BorderRadius.all(Radius.circular(Diamensions.width10),
                    ),
                    child: Container(
                      child: Column(
                        children: [
                          Container(

                             height: Diamensions.height145+Diamensions.height10,
                            width: MediaQuery.of(context).size.width,
                            foregroundDecoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage("${bloglist[position].image}"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          Divider(color: ColorConstants.greencolor,thickness: 1.3,),
                          Container(
                            padding:EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5),
                            child: Text(
                                "${bloglist[position].title}",
                              style: TextStyle(
                                fontSize: Diamensions.fontsize17,

                              ),
                            ),
                          ),
                           Divider(color: ColorConstants.greencolor,thickness: 1.3,),
                           Container(
                             alignment: Alignment.centerRight,
                             child: TextButton(onPressed: () {
                               String urlselected = bloglist[position].link.toString();

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(blogUrl: urlselected,)));
                             },
                               child: Text("Read More...",style: TextStyle(
                                 color: ColorConstants.iconColror
                               ),),

                             ),
                           )
                          // Container(
                          //   alignment: Alignment.center,
                          //   padding: EdgeInsets.symmetric(horizontal: Diamensions.width10,vertical: Diamensions.height5),
                          //   child: FloatingActionButton.extended(
                          //     heroTag: "$position",
                          //       onPressed: (){
                          //     String urlselected = bloglist[position].link.toString();
                          //
                          //     Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(blogUrl: urlselected,)));
                          //   }, label: Text("Read More...")
                          //   ),
                          // )


                        ],
                      ),
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

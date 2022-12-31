
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

class SpecialDealSearch extends StatefulWidget {
  final String? isoneway;
   SpecialDealSearch({Key? key,this.isoneway}) : super(key: key);

  @override
  State<SpecialDealSearch> createState() => _SpecialDealSearchState();
}

class _SpecialDealSearchState extends State<SpecialDealSearch> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConstants.iconColror,
            ),
          ),
          title: const Text(
            'Special Call',
            style: TextStyle(color: ColorConstants.iconColror),
          ),

      ),
      body: Container(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, position) {
              return Container(

                margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),

                child: Material(
                  elevation: Diamensions.width10,
                  borderRadius: BorderRadius.all(Radius.circular(Diamensions.width40)
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorConstants.whitecolr,
                        borderRadius: BorderRadius.all(Radius.circular(Diamensions.width40)
                        )
                    ),
                    padding: EdgeInsets.symmetric(vertical: Diamensions.height10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: Diamensions.width10*6,
                                margin: EdgeInsets.only(left:Diamensions.width10,),
                                child: Image.network("https://flightstoindia.com/wp-content/themes/flights-to-india/img/flight-logo.png"))
                            // Container(
                            //   foregroundDecoration: const BoxDecoration(
                            //     image: DecorationImage(
                            //         image: NetworkImage("https://flightstoindia.com/wp-content/themes/flights-to-india/img/flight-logo.png"),
                            //         fit: BoxFit.fill),
                            //   ),
                            // ),

                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("\$700 *",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize30-Diamensions.fontsize5
                                  ),
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("SPL Fare **",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize20
                                  ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("JFK",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize20
                                  ),
                                  ),
                                ),
                                (widget.isoneway == "one")?
                                Container(
                                  height:Diamensions.width10*3,
                                  width: Diamensions.width10*3,
                                  margin: EdgeInsets.only(bottom: Diamensions.width10,left: Diamensions.width10),
                                  foregroundDecoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/forward.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ):
                                Container(
                                  height:Diamensions.width10*3,
                                  width: Diamensions.width10*3,
                                  margin: EdgeInsets.only(bottom: Diamensions.width10,left: Diamensions.width10),
                                  foregroundDecoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("assets/images/double-arrow.png"),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Container(
                                  margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                                  child: Text("DEL",style: TextStyle(
                                      color: ColorConstants.backgroundColor,
                                      fontSize: Diamensions.fontsize20
                                  ),
                                  ),
                                ),
                              ],
                            ),


                          ],
                        ),
                        GestureDetector(
                          onTapDown: (TapDownDetails details){
                            _showPopupMenu();
                          },
                          child: Container(
                            height: 58,
                            width: 58,
                            margin: EdgeInsets.only(right: Diamensions.width5),
                            foregroundDecoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/telephone.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),

                        // Column(
                        //   children: [
                        //     Container(
                        //       margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                        //       child: Text("\$700 *",style: TextStyle(
                        //           color: ColorConstants.backgroundColor,
                        //           fontSize: Diamensions.fontsize20
                        //       ),
                        //       ),
                        //     ),
                        //     Container(
                        //       margin:EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.width10),
                        //       child: Text("SPL Fare **",style: TextStyle(
                        //           color: ColorConstants.backgroundColor,
                        //           fontSize: Diamensions.fontsize20
                        //       ),
                        //       ),
                        //     ),
                        //     Container(
                        //       alignment: Alignment.center,
                        //       padding: EdgeInsets.symmetric(horizontal: Diamensions.width10,vertical: Diamensions.height5),
                        //       child: FloatingActionButton.extended(
                        //           heroTag: "$position",
                        //           onPressed: (){
                        //             // String urlselected = bloglist[position].link.toString();
                        //
                        //             //  Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(blogUrl: urlselected,)));
                        //           }, label: Text("Call Now")
                        //       ),
                        //     )
                        //   ],
                        // )

                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
  void _showPopupMenu() async{

    await showMenu(context: context,
      constraints: BoxConstraints(
          maxWidth: 135,
          maxHeight: 200
      ),
      position: RelativeRect.fromLTRB(-130, 200, 0, 0),
      items: [
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("assets/images/fly_deal_fare_icon_canada.png"),
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: Diamensions.width5),
                      child: Text("Canada"))
              )
            ],

          ),

        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("assets/images/fly_deal_farc_icon_india.png"),
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: Diamensions.width5),
                      child: Text("India")
                  )
              )
            ],

          ),

        ),

        PopupMenuItem(
          value: 3,
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: Image.asset("assets/images/fly_deal_fare_icon_usa.png"),
              ),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(left: Diamensions.width5),
                      child: Text("USA")
                  )
              )
            ],

          ),

        ),
      ],
      elevation: 8.0,
    ).then((value) {

      if(value != null){
        switch(value){
          case 1:
            FlutterPhoneDirectCaller.callNumber("+919814614000");
            break;
          case 2:
            FlutterPhoneDirectCaller.callNumber("+18662145391");
            break;
          case 3:
            FlutterPhoneDirectCaller.callNumber("+18777711620");
            break;
        }
      }
    });
  }
}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/ui/referral_screen.dart';
import 'package:fly_deal_fare/ui/result_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

class Reward extends StatelessWidget {
  const Reward({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Diamensions.height10,
            ),
            Container(
                alignment: Alignment.center,
                child: Text("Referral Bonus Programme",
                  style: TextStyle(
                      color: ColorConstants.backgroundColor,
                      fontSize: Diamensions.fontsize30-Diamensions.fontsize5,
                      decoration: TextDecoration.underline
                  ),
                )
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,

              child: Container(
                margin: EdgeInsets.symmetric(horizontal: Diamensions.height10,vertical: Diamensions.height5),
                child: Card(
                  elevation: 10,
                  color: ColorConstants.greencolor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Diamensions.width10,vertical: Diamensions.height5),
                    child: Column(
                      children: [
                        Text("Refer us with a contact to your friend if he book a ticket with us we will give you  \$20 refferal bonus",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Diamensions.fontsize17,

                          ),

                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReferralFormScreen()));
                        },
                            child:Text("Ok, Refering to Friend",
                              style: TextStyle(
                                  color: ColorConstants.backgroundColor,
                                  fontSize: Diamensions.fontsize17,
                                  decoration: TextDecoration.underline
                              ),

                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: Diamensions.height5),
              child: Text("Previous Refferral",
                style: TextStyle(
                    fontSize: 23,
                    decoration: TextDecoration.underline,
                    color: ColorConstants.backgroundColor
                ),
              ),
            ),
            SizedBox(
              height: Diamensions.height10,
            ),
            Container(
              child: ListView.builder(
                 physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 12,
                  itemBuilder: (context, position) {
                    return Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: Diamensions.width10),
                        child: Card(
                          child: Column(
                            children: [
                             Row(
                               mainAxisSize: MainAxisSize.max,
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Column(
                                   children: [
                                      Container(
                                        margin: EdgeInsets.only(left: Diamensions.width10,top: Diamensions.height5,bottom: Diamensions.height5),
                                        child: Text("Rajesh Kumar",style: TextStyle(
                                          fontSize: Diamensions.fontsize20
                                        ),),
                                      ),
                                     Container(
                                       margin: EdgeInsets.only(left: Diamensions.width10,bottom: Diamensions.height5),
                                       child: Text("2023/03/04",style: TextStyle(
                                           fontSize: Diamensions.fontsize17
                                       ),),
                                     ),
                                   ],
                                 ),

                                 Container(
                                   margin: EdgeInsets.only(right: Diamensions.width10*2),
                                   child: (position%2==1)? SizedBox(
                                     height: Diamensions.height40,
                                     width: Diamensions.width40,
                                     child: Image.asset("assets/images/correct.png"),
                                   ):SizedBox(
                                     height: Diamensions.height40,
                                     width: Diamensions.width40,
                                     child: Image.asset("assets/images/remove.png"),
                                   ),
                                 )

                               ],
                             )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )


          ],
        ),
      ),


    );
  }


}

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/ui/referral_screen.dart';
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
            )

          ],
        ),
      ),
    );
  }


}

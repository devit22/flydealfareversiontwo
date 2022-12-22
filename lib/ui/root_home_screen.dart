
import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/ui/deals_screen.dart';
import 'package:fly_deal_fare/ui/login_screen.dart';
import 'package:fly_deal_fare/ui/myaccount_screen.dart';
import 'package:fly_deal_fare/ui/mytrips_screen.dart';
import 'package:fly_deal_fare/ui/register_screen.dart';
import 'package:fly_deal_fare/ui/reward_screen.dart';
import 'package:fly_deal_fare/ui/search_screen.dart';
import 'package:fly_deal_fare/ui/setting.dart';
import 'package:fly_deal_fare/ui/notification_screen.dart';
import 'package:fly_deal_fare/ui/update_screen.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';
import 'package:get/get.dart';



class HomeScreen extends StatefulWidget {
  Data? loggedindata;
   HomeScreen({Key? key, this.loggedindata}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var pageIndex = 0;
var  pages = [];

late FirebaseAuth auth;
  // static const String androidChannelKey =
  //     "eyJzZXR0aW5nc191cmwiOiJodHRwczovL3VjbWFzc25ldHRvbmljcy56ZW5kZXNrLmNvbS9tb2JpbGVfc2RrX2FwaS9zZXR0aW5ncy8wMUc3WEpNRUg0UkdIMDg1QkdBMlg1MzJONi5qc29uIn0=";
  // static const String iosChannelKey =
  //     "eyJzZXR0aW5nc191cmwiOiJodHRwczovL3VjbWFzc25ldHRvbmljcy56ZW5kZXNrLmNvbS9tb2JpbGVfc2RrX2FwaS9zZXR0aW5ncy8wMUc4SllHUFFCUEVIRkJaQlJOWUJWOU1ZVi5qc29uIn0=";
  // final List<String> channelMessages = [];

  @override
  void initState() {
    super.initState();
     auth = FirebaseAuth.instance;
     pages = [
      Search(),
      Reward(),
      MyTrips(),
      Deals(),
      MyAccount(loggedInuser: widget.loggedindata,),
      Settings(),
      NotificationScreen()
    ];
  //  print(" welcome! ${widget.data!.name}");
   
    // ZendeskMessaging.initialize(
    //     androidChannelKey: androidChannelKey, iosChannelKey: iosChannelKey);
    //  Optional, observe all incoming messages
    // ZendeskMessaging.setMessageHandler((type, arguments) {
    //   setState(() {
    //     channelMessages.add("$type - args=$arguments");
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
              height: 75,
              width: 200,
              child: Image.asset(
                "assets/images/mydrawyerlogo.png",
                fit: BoxFit.contain,
              )),
          iconTheme: const IconThemeData(color: Colors.blue),
          actions: [
            GestureDetector(
              onTapDown: (TapDownDetails details){
               _showPopupMenu(details.globalPosition);
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: Diamensions.width5),
                width: 40,
                  height: 40,
                  child: Image.asset("assets/images/telephone.png")),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ), //BoxDecoration
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset("assets/images/mydrawyerlogo.png"),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LogInScreen()));
                          },
                          child: const Text(
                            "Sign In ",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ) //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                title: const Text(
                  ' My Account',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 4;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Setting',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 5;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_alert_sharp,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Notification',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  setState(() {
                    pageIndex = 6;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.chat,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Chat',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  //ZendeskMessaging.show();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.blue,
                ),
                title: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  auth.signOut();
FacebookAuth.instance.logOut().then((value) => {
Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen()))
});

                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset(
                        'assets/images/search_large.png',
                        color: Colors.blue,
                      ))),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/images/reward_large.png',
                      color: Colors.blue,
                    )),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/images/trip_large.png',
                      color: Colors.blue,
                    )),
              ),
              IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                icon: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      'assets/images/deal_large.png',
                      color: Colors.blue,
                    )),
              ),
            ],
          ),
        ),
        body: pages[pageIndex]);
  }

  void _showPopupMenu(Offset offset) async{

    await showMenu(context: context,
        constraints: BoxConstraints(
          maxWidth: 135,
          maxHeight: 200
        ),
        position: RelativeRect.fromLTRB(100, 80, 5, 0),
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
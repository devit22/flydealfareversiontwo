import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/ui/flights.dart';

import 'package:flutter/material.dart';

import 'deals_screen.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);
  TabBar get _tabBar => TabBar(
        indicatorColor: ColorConstants.whitecolr,
        tabs: [
          const Tab(
            icon: Icon(Icons.flight_takeoff_outlined),
            text: "Flights",
          ),
          Tab(
            icon: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset('assets/images/deal_large.png')),
            text: "SecretDeals",
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              toolbarHeight: 0,
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: ColoredBox(
                  color: ColorConstants.backgroundColor,
                  child: _tabBar,
                ),
              )),
          body: const TabBarView(
            children: [Flights(),Deals(),],
          ),
        ));
  }
}

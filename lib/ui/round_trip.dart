import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/ui/result_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

class RoundTrip extends StatefulWidget {
  const RoundTrip({Key? key, this.restorationId}) : super(key: key);

  final String? restorationId;
  @override
  State<RoundTrip> createState() => _RoundTripState();
}

class _RoundTripState extends State<RoundTrip> {
  String startDateText = "Depart Date";
  String endDateText = "Return Date";

  String dropdownvalueg = 'Economy';
  var passengerInfo = "Pick Passenger and More";
  var adultcountg = 0;
  var childcountg = 0;
  var infantcountg = 0;

  var departSuggestionValue = "Depart City";
  var departAirportCodeValue = "some";
  var destinationSuggestionValue = "Destination City";
  var destinationAirportCodeValue = "some";

  var fieldText = TextEditingController();
  var isPressed = false;
  var isPressedDes = false;
  var i = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            width: Diamensions.width310,
            margin:
                 EdgeInsets.only(left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
            child: TypeAheadField<Output?>(
              hideSuggestionsOnKeyboardHide: true,
              textFieldConfiguration: TextFieldConfiguration(
                  style: const TextStyle(color: ColorConstants.whitecolr),
                  controller: TextEditingController(
                      text: (isPressed) ? departSuggestionValue : ""),
                  decoration: InputDecoration(
                      hintText: departSuggestionValue,
                      hintStyle:
                          const TextStyle(color: ColorConstants.whitecolr),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.whitecolr, width: 2.0)),
                      prefixIcon: const Icon(
                        Icons.place_outlined,
                        color: ColorConstants.whitecolr,
                      ))),
              suggestionsCallback: UserApiService.getsuggestionairport,
              itemBuilder: (context, Output? suggestion) {
                final user = suggestion;

                i++;
                Color colors = (i % 2 == 0) ? Colors.blue : Colors.white;
                Color textcolor = (i % 2 == 0) ? Colors.white : Colors.blue;

                return Container(
                  height: Diamensions.width10*3,
                  color: colors,
                  padding:  EdgeInsets.only(
                      left: Diamensions.width5, right: Diamensions.width5, top: Diamensions.height5/2, bottom: Diamensions.height5/2),
                  child: Text(
                    "${user?.name} (${user?.code})",
                    style: TextStyle(color: textcolor, fontSize: Diamensions.fontsize19),
                  ),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                height: Diamensions.width10*8,
                child: const Center(
                  child: Text(
                    'No user found',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              onSuggestionSelected: (Output? suggestion) {
                final user = suggestion!;
                setState(() {
                  isPressed = true;
                  departSuggestionValue = user.name!;
                  departAirportCodeValue = user.code!;
                });
              },
            ),
          ),
          Container(
            width: Diamensions.width310,
            margin:
            EdgeInsets.only(left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
            child: TypeAheadField<Output?>(
              hideSuggestionsOnKeyboardHide: true,
              textFieldConfiguration: TextFieldConfiguration(
                  style: const TextStyle(color: ColorConstants.whitecolr),
                  controller: TextEditingController(
                      text: (isPressedDes) ? destinationSuggestionValue : ""),
                  decoration: InputDecoration(
                      hintText: destinationSuggestionValue,
                      hintStyle:
                          const TextStyle(color: ColorConstants.whitecolr),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.whitecolr, width: 2.0)),
                      prefixIcon: const Icon(
                        Icons.place_outlined,
                        color: ColorConstants.whitecolr,
                      ))),
              suggestionsCallback: UserApiService.getsuggestionairport,
              itemBuilder: (context, Output? suggestion) {
                final user = suggestion;

                i++;
                Color colors = (i % 2 == 0) ? Colors.blue : Colors.white;
                Color textcolor = (i % 2 == 0) ? Colors.white : Colors.blue;

                return Container(
                  height: Diamensions.width10*3,
                  color: colors,
                  padding: EdgeInsets.only(
                      left: Diamensions.width5, right: Diamensions.width5, top: Diamensions.height5/2, bottom: Diamensions.height5/2),
                  child: Text(
                    "${user?.name} (${user?.code})",
                    style: TextStyle(color: textcolor, fontSize: Diamensions.fontsize19),
                  ),
                );
              },
              noItemsFoundBuilder: (context) => Container(
                height: Diamensions.width10*8,
                child: const Center(
                  child: Text(
                    'No user found',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              onSuggestionSelected: (Output? suggestion) {
                final user = suggestion!;
                setState(() {
                  isPressedDes = true;
                  destinationSuggestionValue = user.name!;
                  destinationAirportCodeValue = user.code!;
                });
              },
            ),
          ),
          Container(
            width: Diamensions.width310,
            child: Row(
              children: [
                Container(
                    height: Diamensions.height58,
                    width: Diamensions.width145,
                    margin:  EdgeInsets.only(
                         right: Diamensions.width5, top: Diamensions.height10, bottom: Diamensions.height5),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                          fixedSize: const Size(50, 40),
                          alignment: const AlignmentDirectional(-1.0, 0),
                          side: const BorderSide(
                              width: 2,
                              color: ColorConstants.whitecolr,
                              style: BorderStyle.solid)),
                      onPressed: () async {
                        await showDateDialog(context);
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        size:  23,
                        color: ColorConstants.whitecolr,
                      ),
                      label: Text(
                        startDateText,
                        style: const TextStyle(color: ColorConstants.whitecolr),
                      ),
                    )),
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                      height: Diamensions.height58,

                      margin:  EdgeInsets.only(
                          left: Diamensions.width10,  top: Diamensions.height10, bottom: Diamensions.height5),
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                            fixedSize: const Size(50, 40),
                            alignment: const AlignmentDirectional(-1.0, 0),
                            side: const BorderSide(
                                width: 2,
                                color: ColorConstants.whitecolr,
                                style: BorderStyle.solid)),
                        onPressed: () async {
                          await showDateDialog(context);
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          size: 23,
                          color: ColorConstants.whitecolr,
                        ),
                        label: Text(
                          endDateText,
                          style: const TextStyle(color: ColorConstants.whitecolr),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Container(
            width: Diamensions.width310,
              height: 58,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 5),
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    fixedSize: const Size(50, 40),
                    alignment: const AlignmentDirectional(-1.0, 0),
                    side: const BorderSide(
                        width: 2,
                        color: ColorConstants.whitecolr,
                        style: BorderStyle.solid)),
                onPressed: () async {
                  await passendPickDialog(context);
                },
                icon:  Icon(
                  Icons.calendar_month_outlined,
                  size: Diamensions.iconsize23,
                  color: ColorConstants.whitecolr,
                ),
                label: Text(
                  passengerInfo,
                  style: const TextStyle(color: ColorConstants.whitecolr),
                ),
              )),
          Container(
            width: Diamensions.width310,
            margin:
                 EdgeInsets.only(left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
            child: FloatingActionButton.extended(
              backgroundColor: ColorConstants.greencolor,
              onPressed: () {
                var myurl3 =
                    "https://flights.flightinfo.live/web/air/default.aspx?siid=949880&AirSegCount=2&aCount=$adultcountg&sCount=0&cCount=$childcountg&yCount=$infantcountg&iSCount=0&iLCount=0&Class=$dropdownvalueg&DirectFlight=&Refundable=&AirSeg_1=$departAirportCodeValue|$destinationAirportCodeValue|$startDateText||-1|3|&AirSeg_2=$destinationAirportCodeValue|$departAirportCodeValue|$endDateText||-1|3|";
                //var myurl2 = "https://flights.flightinfo.live/web/air/default.aspx?siid=131174&AirSegCount=2&aCount=$adultcountg&sCount=0&cCount=$childcountg&yCount=$infantcountg&iSCount=0&iLCount=0&Class=$dropdownvalueg&DirectFlight=&Refundable=&AirSeg_1=$departAirportCodeValue|$destinationAirportCodeValue|$startDateText||-1|3|&AirSeg_2=$destinationAirportCodeValue|$departAirportCodeValue|$endDateText||-1|3|";
var myurl4 = "https://flights.flydealfare.com/web/air/default.aspx?siid=105302&AirSegCount=2&aCount=$adultcountg&sCount=0&cCount=$childcountg&yCount=$infantcountg&iSCount=0&iLCount=0&Class=$dropdownvalueg&DirectFlight=&Refundable=&AirSeg_1=$departAirportCodeValue|$destinationAirportCodeValue|$startDateText||-1|3|&AirSeg_2=$destinationAirportCodeValue|$departAirportCodeValue|$endDateText||-1|3|";
                //var  url = "https://flights.flydealfare.com/web/air/default.aspx?siid=105302&AirSegCount=2&aCount=$adultcountg&sCount=0&cCount=$childcountg&yCount=$infantcountg&iSCount=0&iLCount=0&Class=$dropdownvalueg&DirectFlight=&Refundable=&AirSeg_1=$departAirportCodeValue|$destinationAirportCodeValue|$startDateText||-1|3|&AirSeg_2=$destinationAirportCodeValue|$departAirportCodeValue|$endDateText||-1|3|";
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultScreen(
                              url: myurl4,
                            )));
              },
              label: const Text(
                'Search Now ',
                style: TextStyle(color: Colors.white, fontSize: 19),
              ),
            ),
          ),
          Container(
            margin:
            EdgeInsets.only(left: Diamensions.width10*2, right: Diamensions.width10*2, top: Diamensions.height10, bottom: Diamensions.height5),
            child: TextButton.icon(
              onPressed: () {},
              icon: SizedBox(
                  height: Diamensions.height10*2,
                  width: Diamensions.width10*2,
                  child: Image.asset('assets/images/reward_large.png')),
              label: const Text('Price Match Promise'),
            ),
          )
        ],
      ),
    );
  }

  Future<void> showDateDialog(BuildContext context) async {
    final picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(3050),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme(
                      brightness: Brightness.light,
                      primary: ColorConstants.iconColror,
                      onPrimary: Colors.white,
                      secondary: Colors.white,
                      onSecondary: Colors.white,
                      error: Colors.red,
                      onError: Colors.red,
                      background: Colors.white,
                      onBackground: Colors.white,
                      surface: ColorConstants.backgroundColor,
                      onSurface: ColorConstants.backgroundColor)),
              child: child!);
        });

    if (picked != null) {
      setState(() {
        startDateText =
            "${picked.start.month}/${picked.start.day}/${picked.start.year}";
        endDateText =
            "${picked.end.month}/${picked.end.day}/${picked.end.year}";
      });
    }
  }

  Future<void> passendPickDialog(BuildContext context) async {
    var adultcount = 0;
    var childcount = 0;
    var infantcount = 0;
    String dropdownvalue = 'Economy';
    var items = [
      'Economy',
      'First',
      'Business',
      'Premium',
    ];

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: 350,
                        alignment: Alignment.topLeft,
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: ColorConstants.iconColror,
                          ),

                          // Array list of items
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                    color: ColorConstants.iconColror,
                                    fontSize: 17),
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                              width: Diamensions.width53,
                              height: Diamensions.height40,
                              alignment: Alignment.center,
                              margin:  EdgeInsets.only(right: Diamensions.width10),
                              child:  Text(
                                "Adults",
                                style: TextStyle(
                                    color: ColorConstants.iconColror,
                                    fontSize: Diamensions.fontsize16),
                              )
                          ),
                          Container(
                            width: Diamensions.width40,
                            height: Diamensions.height40,
                            margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (adultcount > 0) {
                                    adultcount = adultcount - 1;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                  alignment: AlignmentDirectional.center,
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      ColorConstants.iconColror)),
                              child: Container(
                                padding: EdgeInsets.only(right: Diamensions.width5*3,bottom: Diamensions.width5),
                                child:  Text("-   ",
                                    style: TextStyle(
                                        color: ColorConstants.whitecolr,
                                        fontSize: Diamensions.fontsize20)),
                              ),
                            ),
                          ),
                          Container(
                              width: Diamensions.width40,
                              height: Diamensions.height40,
                              child: Text(
                                " $adultcount",
                                style:  TextStyle(
                                    color: ColorConstants.iconColror,
                                    fontSize: Diamensions.fontsize30),
                              )),
                          Container(
                            width: Diamensions.width40,
                            height: Diamensions.height40,
                            margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (adultcount <9) {
                                    adultcount = adultcount + 1;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      ColorConstants.iconColror)),
                              child: Container(
                                padding: EdgeInsets.only(right: Diamensions.width5*3,bottom: Diamensions.height5),
                                child:  Text("+   ",
                                    style: TextStyle(
                                        color: ColorConstants.whitecolr,
                                        fontSize: Diamensions.fontsize20)),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                              width: Diamensions.width53,
                              height: Diamensions.height40,
                              alignment: Alignment.center,
                              // padding: EdgeInsets.only(top: Diamensions.height10),
                              margin:  EdgeInsets.only(right: Diamensions.width10),
                              child:  Text(
                                "Child",
                                style: TextStyle(
                                    color: ColorConstants.iconColror, fontSize: Diamensions.fontsize16),
                              )),
                          Container(
                            width: Diamensions.width40,
                            height: Diamensions.height40,
                            margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (childcount > 0) {
                                    childcount = childcount - 1;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      ColorConstants.iconColror)),
                              child: Container(
                                padding: EdgeInsets.only(right: Diamensions.width5*3,bottom: Diamensions.width5),
                                child:  Text("-   ",
                                    style: TextStyle(
                                        color: ColorConstants.whitecolr,
                                        fontSize: Diamensions.fontsize20)),
                              ),
                            ),
                          ),
                          Container(
                              width: Diamensions.width40,
                              height: Diamensions.height40,
                              child: Text(
                                " $childcount",
                                style:  TextStyle(
                                    color: ColorConstants.iconColror, fontSize: Diamensions.fontsize30),
                              )),
                          Container(
                            width: Diamensions.width40,
                            height: Diamensions.height40,
                            margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (childcount <9 ) {
                                      childcount = childcount + 1;
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(
                                        ColorConstants.iconColror)),
                                child:  Container(
                                  padding: EdgeInsets.only(right: Diamensions.width5*3,bottom: Diamensions.height5),
                                  child:  Text("+   ",
                                      style: TextStyle(
                                          color: ColorConstants.whitecolr,
                                          fontSize: Diamensions.fontsize20)),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: [
                          Container(
                              width: Diamensions.width53,
                              height: Diamensions.height40,
                              alignment: Alignment.center,
                              margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                              child:  Text(
                                "Infants",
                                style: TextStyle(
                                    color: ColorConstants.iconColror, fontSize: Diamensions.fontsize16),
                              )
                          ),
                          Container(
                            width: Diamensions.width40,
                            height: Diamensions.height40,
                            margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (infantcount > 0) {
                                    infantcount = infantcount - 1;
                                  }
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      ColorConstants.iconColror)),
                              child:  Container(
                                padding: EdgeInsets.only(right: Diamensions.width5*3,bottom: Diamensions.width5),
                                child:  Text("-   ",
                                    style: TextStyle(
                                        color: ColorConstants.whitecolr,
                                        fontSize: Diamensions.fontsize20)),
                              ),
                            ),
                          ),
                          Container(
                              width: Diamensions.width40,
                              height: Diamensions.height40,
                              child: Text(
                                " $infantcount",
                                style:  TextStyle(
                                    color: ColorConstants.iconColror,
                                    fontSize: Diamensions.fontsize30),
                              )),
                          Container(
                            width: Diamensions.width40,
                            height: Diamensions.height40,

                            margin:  EdgeInsets.only(left: Diamensions.width5,right: Diamensions.width5,top: Diamensions.height5,bottom: Diamensions.height5),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (infantcount < 9) {
                                      infantcount = infantcount + 1;
                                    }
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorConstants.iconColror)),
                                child:  Container(
                                  alignment: Alignment.center,
                                  // padding: EdgeInsets.only(right: Diamensions.width5*3,bottom: Diamensions.height5),
                                  child:  Text("+   ",
                                      style: TextStyle(
                                          color: ColorConstants.whitecolr,
                                          fontSize: Diamensions.fontsize20)),
                                )
                            ),
                          )

                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      dropdownvalueg = dropdownvalue;
                      adultcountg = adultcount;
                      childcountg = childcount;
                      infantcountg = infantcount;
                      passengerInfo =
                      " $dropdownvalueg, A : $adultcountg, C: $childcountg, I: $infantcountg";
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: ColorConstants.iconColror),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: ColorConstants.iconColror),
                  ))
            ],
          );
        });
  }
}

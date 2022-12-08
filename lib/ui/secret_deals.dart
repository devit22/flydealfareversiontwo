import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';

class SecretDeals extends StatefulWidget {
  const SecretDeals({Key? key}) : super(key: key);

  @override
  State<SecretDeals> createState() => _SecretDealsState();
}

class _SecretDealsState extends State<SecretDeals> {
  String dropdownvalueg = 'Economy';
  var selectDateText = "Depart Date ";
  var passengerInfo = "Pick Passenger and More";
  var adultcountg = 0;
  var childcountg = 0;
  var infantcountg = 0;
  var departSuggestionValue = "Depart City";
  var destinationSuggestionValue = "Destination City";
  var fieldText = TextEditingController();
  var isPressed = false;
  var isPressedDes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secret Deals"),
        toolbarHeight: 0,
      ),
      body: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(color: ColorConstants.whitecolr),
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: const Text(
              "Please Fill Form to contact you personally",
              style: TextStyle(
                  color: ColorConstants.iconColror,
                  fontSize: 23,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            color: ColorConstants.backgroundColor,
            child: Column(
              children: [
                Container(
                  width: 350,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TypeAheadField<Output?>(
                    hideSuggestionsOnKeyboardHide: true,
                    textFieldConfiguration: TextFieldConfiguration(
                        style: const TextStyle(color: ColorConstants.whitecolr),
                        controller: TextEditingController(
                            text: (isPressed) ? departSuggestionValue : ""),
                        decoration: InputDecoration(
                            hintText: departSuggestionValue,
                            hintStyle: const TextStyle(
                                color: ColorConstants.whitecolr),
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
                                    color: ColorConstants.whitecolr,
                                    width: 2.0)),
                            prefixIcon: const Icon(
                              Icons.place_outlined,
                              color: ColorConstants.whitecolr,
                            ))),
                    suggestionsCallback: UserApiService.getsuggestionairport,
                    itemBuilder: (context, Output? suggestion) {
                      final user = suggestion;
                      return Row(
                        children: [Text(user!.name!), Text(" (${user.code}) ")],
                      );
                    },
                    noItemsFoundBuilder: (context) => Container(
                      height: 80,
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
                      });
                    },
                  ),
                ),
                Container(
                  width: 350,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TypeAheadField<Output?>(
                    hideSuggestionsOnKeyboardHide: true,
                    textFieldConfiguration: TextFieldConfiguration(
                        style: const TextStyle(color: ColorConstants.whitecolr),
                        controller: TextEditingController(
                            text: (isPressedDes)
                                ? destinationSuggestionValue
                                : ""),
                        decoration: InputDecoration(
                            hintText: destinationSuggestionValue,
                            hintStyle: const TextStyle(
                                color: ColorConstants.whitecolr),
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
                                    color: ColorConstants.whitecolr,
                                    width: 2.0)),
                            prefixIcon: const Icon(
                              Icons.place_outlined,
                              color: ColorConstants.whitecolr,
                            ))),
                    suggestionsCallback: UserApiService.getsuggestionairport,
                    itemBuilder: (context, Output? suggestion) {
                      final user = suggestion;
                      return Row(
                        children: [Text(user!.name!), Text(" (${user.code}) ")],
                      );
                    },
                    noItemsFoundBuilder: (context) => Container(
                      height: 80,
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
                      });
                    },
                  ),
                ),

                //Depart Date value
                Container(
                    width: 350,
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
                        await showDateDialog(context);
                      },
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        size: 23,
                        color: ColorConstants.whitecolr,
                      ),
                      label: Text(
                        selectDateText,
                        style: const TextStyle(color: ColorConstants.whitecolr),
                      ),
                    )),
                Container(
                    width: 350,
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
                      icon: const Icon(
                        Icons.calendar_month_outlined,
                        size: 23,
                        color: ColorConstants.whitecolr,
                      ),
                      label: Text(
                        "$passengerInfo",
                        style: const TextStyle(color: ColorConstants.whitecolr),
                      ),
                    )),
                Container(
                  width: 350,
                  height: 58,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TextFormField(
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration: const InputDecoration(
                      labelText: 'Enter email',
                      labelStyle: TextStyle(color: ColorConstants.whitecolr),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.whitecolr, width: 2.0)),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: ColorConstants.whitecolr,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 58,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TextFormField(
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration: const InputDecoration(
                      labelText: 'Enter Name',
                      labelStyle: TextStyle(color: ColorConstants.whitecolr),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.whitecolr, width: 2.0)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: ColorConstants.whitecolr,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  height: 58,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(color: ColorConstants.whitecolr),
                    decoration: const InputDecoration(
                      labelText: 'Enter Number',
                      labelStyle: TextStyle(color: ColorConstants.whitecolr),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.whitecolr, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.whitecolr, width: 2.0)),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: ColorConstants.whitecolr,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 5),
                  child: FloatingActionButton.extended(
                    backgroundColor: ColorConstants.greencolor,
                    onPressed: () {
                      print(" $passengerInfo ");
                    },
                    label: const Text(
                      'Submit Data',
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> showDateDialog(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
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

    if (picked != null && picked != selectDateText) {
      setState(() {
        selectDateText = "${picked.month}/${picked.day}/${picked.year}";
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
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
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
                      Row(
                        children: [
                          Container(
                              width: 45,
                              height: 25,
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
                                "Adults",
                                style: TextStyle(
                                    color: ColorConstants.iconColror,
                                    fontSize: 16),
                              )),
                          Flexible(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 60,
                                  margin: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (adultcount > 0) {
                                          adultcount = adultcount - 1;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorConstants.iconColror)),
                                    child: const Text(" - ",
                                        style: TextStyle(
                                            color: ColorConstants.whitecolr,
                                            fontSize: 20.0)),
                                  ),
                                ),
                                Container(
                                    height: 47,
                                    width: 57,
                                    child: Text(
                                      "  $adultcount",
                                      style: const TextStyle(
                                          color: ColorConstants.iconColror,
                                          fontSize: 30),
                                    )),
                                Container(
                                  height: 50,
                                  width: 60,
                                  margin: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (adultcount < 10) {
                                          adultcount = adultcount + 1;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorConstants.iconColror)),
                                    child: const Text(" + ",
                                        style: TextStyle(
                                            color: ColorConstants.whitecolr,
                                            fontSize: 20.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: 45,
                              height: 25,
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text(
                                "Child",
                                style: TextStyle(
                                    color: ColorConstants.iconColror,
                                    fontSize: 16),
                              )),
                          Flexible(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 60,
                                  margin: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (childcount > 0) {
                                          childcount = childcount - 1;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorConstants.iconColror)),
                                    child: const Text(" - ",
                                        style: TextStyle(
                                            color: ColorConstants.whitecolr,
                                            fontSize: 20.0)),
                                  ),
                                ),
                                Container(
                                    height: 47,
                                    width: 57,
                                    child: Text(
                                      "  $childcount",
                                      style: const TextStyle(
                                          color: ColorConstants.iconColror,
                                          fontSize: 30),
                                    )),
                                Container(
                                  height: 50,
                                  width: 60,
                                  margin: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (childcount < 10) {
                                          childcount = childcount + 1;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorConstants.iconColror)),
                                    child: const Text(" + ",
                                        style: TextStyle(
                                            color: ColorConstants.whitecolr,
                                            fontSize: 20.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: 45,
                              height: 25,
                              margin: const EdgeInsets.only(right: 10),
                              child: const Flexible(
                                child: Text(
                                  "Infants",
                                  style: TextStyle(
                                      color: ColorConstants.iconColror,
                                      fontSize: 16),
                                ),
                              )),
                          Flexible(
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 60,
                                  margin: const EdgeInsets.all(5.0),
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
                                    child: const Text(" - ",
                                        style: TextStyle(
                                            color: ColorConstants.whitecolr,
                                            fontSize: 20.0)),
                                  ),
                                ),
                                Container(
                                    height: 47,
                                    width: 57,
                                    child: Text(
                                      "  $infantcount",
                                      style: const TextStyle(
                                          color: ColorConstants.iconColror,
                                          fontSize: 30),
                                    )),
                                Container(
                                  height: 50,
                                  width: 60,
                                  margin: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (infantcount < 10) {
                                          infantcount = infantcount + 1;
                                        }
                                      });
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                ColorConstants.iconColror)),
                                    child: const Text(" + ",
                                        style: TextStyle(
                                            color: ColorConstants.whitecolr,
                                            fontSize: 20.0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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

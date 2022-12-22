import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

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
  var departairportCode = "some";
  var destinationAirportCode = "some";
  var departSuggestionValue = "Depart City";
  var destinationSuggestionValue = "Destination City";
  var fieldText = TextEditingController();
  var isPressed = false;
  var isPressedDes = false;
  var countrycode = "+91";
  var codetextg = "+91 (IN)";
  var codeg = "+91";
  var smsmcod = "some";
  var numberControler = TextEditingController();
var emailController = TextEditingController();
var nameController = TextEditingController();
var circularvisibility = false;
  void submitdata(){

    setState(() {
      circularvisibility = true;
    });

    var descode = destinationAirportCode;
    var descity = destinationSuggestionValue;
    var depcode = departairportCode;
    var depcity = departSuggestionValue;
    var emailtext = emailController.text.toString();
    var numbertext = numberControler.text.toString();
    var finalnumber = "$countrycode$numbertext";
    var nametext  = nameController.text.toString();
    var departdatetext = selectDateText;
    var passengerinfotext = passengerInfo;

    UserApiService.submitpersondata(descode, descity, depcode, depcity, departdatetext, passengerinfotext, emailtext, finalnumber, nametext).then((value) =>
   {
     setState(() {
       circularvisibility = false;
     }),
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:   Text("${value.result!}"))
    )



    });
   //print("$descode => $descity \n $depcode => $depcity \n $emailtext \n $finalnumber \n $nametext \n $departdatetext \n $passengerinfotext");

    }
  @override
  Widget build(BuildContext context) {
    var i = 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secret Deals"),
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [

          ListView(
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
                      margin:
                      const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
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
                            height: 30,
                            color: colors,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 2.5, bottom: 2.5),
                            child: Text(
                              "${user?.name} (${user?.code})",
                              style: TextStyle(color: textcolor, fontSize: 19),
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) => Container(
                          height: 80,
                          child: const Center(
                            child: Text(
                              'No user found',
                              style: TextStyle(fontSize: 17, color: Colors.blue),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (Output? suggestion) {
                          final user = suggestion!;
                          setState(() {
                            isPressed = true;
                            departSuggestionValue = user.name!;
                            departairportCode = user.code!;
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
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
                            height: 30,
                            color: colors,
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 2.5, bottom: 2.5),
                            child: Text(
                              "${user?.name} (${user?.code})",
                              style: TextStyle(color: textcolor, fontSize: 19),
                            ),
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
                            destinationAirportCode = user.code!;
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
                        controller: emailController,
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
                        controller: nameController,
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
                      height: 58,

                      margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                      width: 350,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            child: TextButton(
                              onPressed: () {
                                showCountryPicker(
                                  context: context,
                                  favorite: <String>['IN'],
                                  //Optional. Shows phone code before the country name.
                                  showPhoneCode: true,
                                  onSelect: (Country country) {


                                    setState(() {
                                      var name = country.countryCode;
                                      codeg = country.phoneCode;

                                      codetextg = "+$codeg ($name)";
                                    });
                                    print("$codetextg");
                                  },
                                  // Optional. Sets the theme for the country list picker.
                                  countryListTheme: CountryListThemeData(
                                    // Optional. Sets the border radius for the bottomsheet.
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                    // Optional. Styles the search field.
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search',
                                      hintText: 'Start typing to search',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child:  Text('$codetextg'),
                            ),
                          ),
                          Flexible(
                            child:Container(
                              margin: EdgeInsets.only(right: 10),
                              child: TextField(
                                onChanged: (value){
                                },
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                controller: numberControler,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Number',
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 350,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 5),
                      child: FloatingActionButton.extended(
                        backgroundColor: ColorConstants.whitecolr,
                        onPressed: () {
                          submitdata();
                          print(" $passengerInfo ");
                        },
                        shape: Border.fromBorderSide(BorderSide(color: ColorConstants.greencolor,)),
                        label: const Text(
                          'Submit Data',
                          style: TextStyle(color: Colors.green, fontSize: 19),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Visibility(
            visible: circularvisibility,
              child: CircularProgressIndicator(color: ColorConstants.greencolor,)
          ),
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
        selectDateText = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Future<void> forgotemaildialog(BuildContext context) async {


    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: const  [
                Divider(
                  height: 2,
                  color: Colors.white,
                  thickness: 2,
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Forgot Password ?",
                  style: TextStyle(
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  height: 2,
                  color: Colors.white,
                  thickness: 2,
                ),
              ],
            ),
            backgroundColor: ColorConstants.backgroundColor,
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 300,
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: ColorConstants.whitecolr),
                          decoration: const InputDecoration(
                              labelText: "Enter Email",
                              labelStyle:
                              TextStyle(color: ColorConstants.whitecolr),
                              hintStyle:
                              TextStyle(color: ColorConstants.whitecolr),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr,
                                    width: 2.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ColorConstants.whitecolr,
                                    width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: ColorConstants.whitecolr,
                                      width: 2.0)),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: ColorConstants.whitecolr,
                              ))),
                    ),
                    Container(
                      width: 300,
                      height: 50,
                      margin: const EdgeInsets.only(top: 10, bottom: 5),
                      child: FloatingActionButton.extended(
                        backgroundColor: ColorConstants.greencolor,
                        onPressed: () {
                        },
                        label: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        });
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

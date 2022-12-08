
import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/Data.dart';
import 'package:fly_deal_fare/models/LoggedInUser.dart';
import 'package:fly_deal_fare/ui/open_pravicy_policy_url.dart';
import 'package:fly_deal_fare/ui/register_screen.dart';
import 'package:fly_deal_fare/ui/root_home_screen.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';




class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late bool _passwordVisible;
  late bool _gmaillayoutVisible = true;
  late bool _numberlayoutVisible = false;
  late bool _otpverifylayoutVisible = false;

  bool circularvisibility = false;
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var numberControler = TextEditingController();
  var otpControler = TextEditingController();
  var nameControler = TextEditingController();
  var forgotemailController = TextEditingController();
  var countrycode = "+91";
  var codetextg = "+91 (IN)";
  var codeg = "+91";
  var smsmcod = "some";
  var verificationID="some";
  late FirebaseAuth auth;
  bool _isloggedIn = false;
  Map _userObj = {};
  @override
  void initState() {
    _passwordVisible = false;
  }
  void singinin() async {

    var emailText = emailControler.text.toString();
    var passwordText = passwordControler.text.toString();

    if (emailText == "" || passwordText == "") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all Fields"))
      );
    } else {
      setState(() {
        circularvisibility = true;
      });

      UserApiService.getLoggedInList(emailText,passwordText).then((value) {
        setState(() {
          circularvisibility = false;
        });

        final map = json.decode(value.body.toString()) as Map<String, dynamic>;
        if(map['data'].runtimeType == String){
          ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:   Text(" ${map['data']}"))
          );
        }else{
          var obj = Data(id :map['data']['id']
              ,name: map['data']['name'],
          email: map['data']['email'],
            mobile: map['data']['mobile'],
            address: map['data']['address'],
            username: map['data']['username'],
            password: map['data']['password'],
            passValue: map['data']['passValue'],
            dated: map['data']['dated'],
            lastLogin: map['data']['lastLogin'],
            source: map['data']['source']
          );

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(data: obj,))
          );
         // print(map['data']['mobile']);
        }
      });
       // LoggedInUser loggedInUser = value.body['data'];

//print(value.reasonPhrase);
//       try {
//         final credential = await FirebaseAuth.instance
//             .signInWithEmailAndPassword(
//             email: emailText,
//             password: passwordText
//         );
//         if (credential.user != null) {
//           setState(() {
//             circularvisibility = false;
//           });
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => HomeScreen())
//           );
//         }
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           circularvisibility = false;
//         });
//         if (e.code == 'user-not-found') {
//           print('No user found for that email.');
//         } else if (e.code == 'wrong-password') {
//           print('Wrong password provided for that user.');
//         }
     }
     }



  void guestuser() async{
    setState(() {
      circularvisibility = true;
    });
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Signed in with temporary account.")));
      print("Signed in with temporary account.");
      if (userCredential.user != null) {
        setState(() {
          circularvisibility = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen())
        );
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }
  void signupt(BuildContext context) async{

    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    // final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(
    //   scopes: ['email', 'profile'],
    //   hostedDomain: '',
    // ).signIn();


    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User user = result.user!;

      if (user != null) {
        print(user.email);
        print(user.displayName);
        print(user.phoneNumber);
        UserApiService.getResgisterelinkList(user.email.toString(),"Not Availble", user.displayName.toString(), "Not Availble", "google").then((value){
         

          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
        });

      }  // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign In Screen",
          style: TextStyle(color: ColorConstants.iconColror),
        ),
      ),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(color: ColorConstants.backgroundColor),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: ColorConstants.whitecolr,
                                ),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                            onPressed: () {
                              FacebookAuth.instance.login(
                                  permissions: ['public_profile',"email"]).then((value) {
                                FacebookAuth.instance.getUserData().then((userdata) async {
                                  setState(() {
                                    _isloggedIn = true;
                                    _userObj = userdata;
                                  });

                                  // UserApiService.getResgisterelinkList("email","Not Availble", user.displayName.toString(), "Not Availble", "google").then((value){
                                  //
                                  //
                                  //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
                                  // });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                });
                              });
                            },
                            icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset('assets/images/facebook.png')),
                            label: Text("Facebook")),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: ColorConstants.whitecolr,
                                ),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                            onPressed: () {
                              signupt(context);
                            },
                            icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset('assets/images/google.png')),
                            label: Text("Google")),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 2,
                        width: 150,
                        color: ColorConstants.whitecolr,
                      ),
                      const Text(
                        "Or",
                        style: TextStyle(
                            color: ColorConstants.whitecolr, fontSize: 18),
                      ),
                      Container(
                        height: 2,
                        width: 150,
                        color: ColorConstants.whitecolr,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        margin: const EdgeInsets.only(top: 10),
                        child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: ColorConstants.whitecolr,
                                ),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                            onPressed: () {
                              setState(() {
                                _gmaillayoutVisible = true;
                                _numberlayoutVisible = false;
                                _otpverifylayoutVisible = false;
                              });
                            },
                            icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset('assets/images/gmail.png')),
                            label: const Text("Gmail")),
                      ),
                      Container(
                        width: 150,
                        height: 50,
                        margin: EdgeInsets.only(top: 10),
                        child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  width: 2,
                                  color: ColorConstants.whitecolr,
                                ),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                            onPressed: () {
                              setState(() {
                                _numberlayoutVisible = true;
                                _gmaillayoutVisible = false;
                                _otpverifylayoutVisible = false;
                              });
                            },
                            icon: SizedBox(
                                height: 30,
                                width: 30,
                                child: Image.asset('assets/images/telephone.png')),
                            label: const Text("Number")),
                      ),
                    ],
                  ),
                  // gmail sign in layout

                  Visibility(
                      visible: _gmaillayoutVisible,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 15,
                            ),
                            child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailControler,
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
                            margin: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              top: 10,
                            ),
                            child: TextFormField(
                                obscureText: !_passwordVisible,
                                keyboardType: TextInputType.text,
                                controller: passwordControler,
                                style: const TextStyle(
                                    color: ColorConstants.whitecolr),
                                decoration: InputDecoration(
                                    labelText: "Enter Password",
                                    labelStyle: const TextStyle(
                                        color: ColorConstants.whitecolr),
                                    hintStyle: const TextStyle(
                                        color: ColorConstants.whitecolr),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.whitecolr,
                                          width: 2.0),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ColorConstants.whitecolr,
                                          width: 2.0),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstants.whitecolr,
                                            width: 2.0)),
                                    prefixIcon: const Icon(
                                      Icons.phonelink_lock,
                                      color: ColorConstants.whitecolr,
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _passwordVisible = !_passwordVisible;
                                          });
                                        },
                                        icon: Icon(
                                          _passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: ColorConstants.whitecolr,
                                        )))),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 5),
                            child: FloatingActionButton.extended(
                              backgroundColor: ColorConstants.greencolor,
                              onPressed: () {
                                singinin();
                              },
                              label: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      )),

                  //number and otp layout

                  Visibility(
                      visible: _numberlayoutVisible,
                      child: Column(
                        children: [
                          //number picker layout
                          Container(
                            height: 62.5,

                            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                            width: 310,
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
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                              ),
                              child: TextFormField(
                                  style: const TextStyle(color: ColorConstants.whitecolr),
                                  keyboardType: TextInputType.name,
                                  controller: nameControler,
                                  decoration: const InputDecoration(
                                    labelText: "Enter Name",
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
                                      Icons.person,
                                      color: ColorConstants.whitecolr,
                                    ),
                                  )
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 5),
                            child: FloatingActionButton.extended(
                              backgroundColor: ColorConstants.greencolor,
                              onPressed: () {
                                setState(() {
                                  _gmaillayoutVisible = false;
                                  _numberlayoutVisible = false;
                                  _otpverifylayoutVisible = true;
                                });
                               getotpfunction();
                              },
                              label: const Text(
                                'Get Otp',
                                style: TextStyle(color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      )),

                  //otp and verify layout

                  Visibility(
                      visible: _otpverifylayoutVisible,
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                              ),
                              child: TextFormField(
                                  style: const TextStyle(color: ColorConstants.whitecolr),
                                  keyboardType: TextInputType.number,
                                  controller: otpControler,
                                  decoration: const InputDecoration(
                                    labelText: "Enter otp",
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
                                      Icons.perm_phone_msg,
                                      color: ColorConstants.whitecolr,
                                    ),
                                  )
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 5),
                            child: FloatingActionButton.extended(
                              backgroundColor: ColorConstants.greencolor,
                              onPressed: () {
                                setState(() {
                                  _numberlayoutVisible = true;
                                  _otpverifylayoutVisible = false;
                                });
                                veriftywithanothernumber();
                              },
                              label: const Text(
                                'Verify Otp ',
                                style: TextStyle(color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ],
                      )
                  ),

                  //Anonymous Sign In

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 5),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            width: 2,
                            color: ColorConstants.whitecolr,
                          ),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)))),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>  HomeScreen()));
                      },
                      child: const Text(
                        " Sign In As Guest",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),

                  Container(
                    height: 30,
                    margin: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {
                          passendPickDialog(context);
                        },
                        child: const Text(
                          " forgot Password? Click here",
                          style: TextStyle(color: ColorConstants.whitecolr),
                        )
                    ),
                  ),

                  Container(
                    height: 30,
                    margin: EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                        },
                        child: const Text(
                          " Not Register? Click here",
                          style: TextStyle(color: ColorConstants.whitecolr),
                        )
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "By Joining FlyDealFare you Agree to FlyDealFare",
                      style: TextStyle(color: ColorConstants.whitecolr),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TextButton(
                            onPressed: () {
                              String url = "https://flydealfare.com/terms-and-conditions/";
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => OpenPravicyPolicyUrl(
                                      url:url,title: "Term & Condition",)));
                            },
                            child: const Text(
                              "Term & Condition",
                              style: TextStyle(
                                  color: ColorConstants.iconColror,
                                  decoration: TextDecoration.underline),
                            )),
                      ),
                      const Text("and ",
                          style: TextStyle(color: ColorConstants.whitecolr)),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => const OpenPravicyPolicyUrl(url:"https://flydealfare.com/privacy-policy/",title: "Privacy Policy",)));
                          },
                          child: const Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: ColorConstants.iconColror,
                                decoration: TextDecoration.underline),
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: circularvisibility,
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: ColorConstants.iconColror,
              ),
            ),
          ),
        ],

      ),

    );
  }
  void getotpfunction() async {
    var numberText = numberControler.text.toString().trim();
    if (numberText.isEmpty || numberText == " " || int.parse(numberText) == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("number text shoult not be empty"))
      );
    } else {

      setState(() {
        _gmaillayoutVisible = false;
        _numberlayoutVisible = false;
        _otpverifylayoutVisible = true;
      });

      var finalnumber = "$countrycode$numberText";
      auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
        phoneNumber: finalnumber,
        timeout: const Duration(seconds: 120),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          smsmcod = credential.smsCode!;
          verfiyuser(smsmcod);
        },
        verificationFailed: (FirebaseAuthException error) {
          if (error.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },

        codeSent: (String verificationId, int? forceResendingToken) async {
          verificationID = verificationId;

          // Create a PhoneAuthCredential with the code

        },
      );
    }
  }

  void verfiyuser(String code) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: code);

    // Sign the user in (or link) with the credential
    var user =  await auth.signInWithCredential(credential);
    if(user != null){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text(" Logged in with number"))
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }


  void veriftywithanothernumber(){
    var otptext = otpControler.text.toString().trim();
    if(otptext.isEmpty || otptext == " " || int.parse(otptext) == 0){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text("opt text shoult not be empty"))
      );
    }else{
      verfiyuser(otptext);
    }

  }

  Future<void> passendPickDialog(BuildContext context) async {


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
                          controller: forgotemailController,
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
                          sendemail();
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
  void sendemail(){
    var emailtext  = forgotemailController.text.toString();
    if(emailtext.isEmpty== true){
      ScaffoldMessenger.of(context).showSnackBar(
          const  SnackBar(content:   Text(" Plese fill email"))
      );
    }else{
      auth.sendPasswordResetEmail(email: emailtext).then((value) => {
      ScaffoldMessenger.of(context).showSnackBar(
      const  SnackBar(content:   Text("Please Check your email "))
      )
      });
      //     .addOnCompleteListener( OnCompleteListener<Void>() {
      // @Override
      // public void onComplete(@NonNull Task<Void> task) {
      // if (task.isSuccessful()) {
      // Log.d(TAG, "Email sent.");
      // }
      // }
      // });
    }
  }
}

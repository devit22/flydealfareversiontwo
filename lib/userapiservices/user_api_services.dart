import 'dart:convert';
import 'dart:math';
import 'package:fly_deal_fare/models/Country.dart';
import 'package:fly_deal_fare/models/LoggedInUser.dart';
import 'package:fly_deal_fare/models/RegisterResponse.dart';
import 'package:fly_deal_fare/models/ReturnRespons.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static String BASE_URL = "http://192.168.1.82/flydealfare/";
  static String BASE_URL2 = "https://flydealfare.com/API/";
  static Future<List<Output>> getsuggestionairport(String queryy) async {
    final url = Uri.parse("https://flydealfare.com/API/airport/list/");
    final response = await http.get(url);
    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => Output.fromJson(json)).where((users) {
        final namelower = users.name!.toLowerCase();
        final codelower = users.code!.toLowerCase();
        final query = queryy.toLowerCase();
        return codelower.startsWith(query) || namelower.startsWith(query);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Country>> getCountriesList(String queryy) async {
    final url = Uri.parse("https://flydealfare.com/API/country/list/");
    final response = await http.get(url);

    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => Country.fromJson(json)).where((users) {
        final namelower = users.name!.toLowerCase();
        final query = queryy.toLowerCase();
        return namelower.startsWith(query);
      }).toList();
    } else {
      throw Exception();
    }
  }


  static Future<RegisterResponse> getResgisterelinkList(String email,String password,String name,String mobile,String source) async {
    final url = Uri.parse("https://flydealfare.com/API/sign_up.php?email=$email&name=$name&password=$password&mobile=$mobile&source=$source");
    final response = await http.get(url);
    final  RegisterResponse registerresposn = RegisterResponse.fromJson(json.decode(response.body));
    if (response.statusCode == 200) {
      return registerresposn;
    } else {
      throw Exception();
    }
  }



  static Future<http.Response> getLoggedInList(String email,String password) async {
    final url = Uri.parse("${BASE_URL}login.php");
    final response = await http.post(url,body: {
      "username":email,
      "password":password

    });
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }

  static Future<ReturnRespons> submitpersondata(
      String descode,String descity,String depcode,String depcity,
      String inserdata,String passendinfo,String email,String mobile,String name
      ) async{
    final url = Uri.parse("${BASE_URL}secretdeal.php");
    final respons =await http.post(url,body: {
      "depcity":depcity,
      "depcode":depcode,
      "descity":descity,
      "descode":descode,
      "insertDate":inserdata,
      "passenger":passendinfo,
      "email":email,
      "mobile":mobile,
      "name":name
    });

    final ReturnRespons returnRespons = ReturnRespons.fromJson(jsonDecode(respons.body.toString()));

    if(respons.statusCode == 200){
      return returnRespons;
    }else{
      throw Exception();
    }
  }
}

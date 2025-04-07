import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practivecovid19/Model/WorldModel.dart';
import 'package:practivecovid19/Services/Utitities/app_util.dart';
class AllService{
  Future<WorldModel> fetchWorld() async{
    final response=await  http.get(Uri.parse(AppUrl.world));
    if(response.statusCode==200){
      var list=jsonDecode(response.body.toString());
      return WorldModel.fromJson(list);
    }
    else{
      throw Exception("error");
    }
  }

  Future<List<dynamic>> fetchCountry() async{
    final response=await  http.get(Uri.parse(AppUrl.countries));
    var list;
    if(response.statusCode==200){
      list=jsonDecode(response.body.toString()); return list;
    }
    else{
      throw Exception("error");
    }
  }
}
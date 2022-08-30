import 'dart:convert';
import 'package:http/http.dart';

class Networking{

  Future<dynamic> getRate(String url) async {
    Response response = await get(Uri.parse(url));

    if(response.statusCode == 200){
      var decodedData = jsonDecode(response.body);

      return decodedData;
    }
    else{
      print(response.statusCode);
    }
  }

}
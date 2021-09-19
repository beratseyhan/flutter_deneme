// import 'package:http/http.dart'as http;
// import 'package:test_app/FlightChart.dart';
//
// class Services{
//   static const String url="https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/departureTimes";
//   static Future<List<FlightChart>> getChart () async{
//     try{
//     final response =await http.get(Uri.parse(url));
//     if(200==response.statusCode){
//       final  List<FlightChart> flightChart=flightChartFromJson(response.body);
//       return flightChart;
//     }else {
//
//     }return List<FlightChart>();
//     }catch (e){
//       return List<FlightChart>();
//     }
//   }
// }


import 'package:flutter_demo/module/FlightChart.dart';
import 'package:http/http.dart'as http;


class Services{
  int counter;
  var chartResult;
  static const String url="https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/departureTimes";
  Future public  <getChart> () async{
    try{
      final response =await http.get(Uri.parse(url));
      if(200==response.statusCode){
        var result = flightChartFromJson(response.body);
        print(result.data[0].arrivalTime);
        chartResult=result;
      }else {
        print(response.statusCode);
      }

    }catch (e){
      print(e.toString());
    }
  }
}
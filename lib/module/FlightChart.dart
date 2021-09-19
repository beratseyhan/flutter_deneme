// To parse this JSON data, do
//
//     final flightChart = flightChartFromJson(jsonString);

import 'dart:convert';

// List<FlightChart> flightChartFromJson(String str) =>List <FlightChart>.from(json.decode(str).map((x)=>FlightChart.fromJson(json.decode(str))));
//
// String flightChartToJson(List<FlightChart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
FlightChart flightChartFromJson(String str) => FlightChart.fromJson(json.decode(str));

String flightChartToJson(FlightChart data) => json.encode(data.toJson());

class FlightChart {
  FlightChart({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  int status;
  bool success;
  String message;
  List<Datum> data;

  factory FlightChart.fromJson(Map<String, dynamic> json) => FlightChart(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.route,
    this.departureTime,
    this.arrivalTime,
    this.tourType,
    this.daysOfWeek,
  });

  String route;
  String departureTime;
  String arrivalTime;
  String tourType;
  List<String> daysOfWeek;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    route: json["route"],
    departureTime: json["departureTime"],
    arrivalTime: json["arrivalTime"],
    tourType: json["tourType"],
    daysOfWeek: List<String>.from(json["daysOfWeek"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "route": route,
    "departureTime": departureTime,
    "arrivalTime": arrivalTime,
    "tourType": tourType,
    "daysOfWeek": List<dynamic>.from(daysOfWeek.map((x) => x)),
  };
}

// To parse this JSON data, do
//
//     final ticketDetails = ticketDetailsFromJson(jsonString);

import 'dart:convert';

TicketDetails ticketDetailsFromJson(String str) => TicketDetails.fromJson(json.decode(str));

String ticketDetailsToJson(TicketDetails data) => json.encode(data.toJson());

class TicketDetails {
  TicketDetails({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  int status;
  bool success;
  String message;
  Data data;

  factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.passengerName,
    this.seatNu,
    this.departureCity,
    this.departureBusStop,
    this.departureTime,
    this.arrivalCity,
    this.arrivalBusStop,
    this.arrivalTime,
    this.tourNumber,
    this.date,
    this.ticketNumber,
    this.bookingNumber,
    this.qrCode,
  });

  String passengerName;
  String seatNu;
  String departureCity;
  String departureBusStop;
  String departureTime;
  String arrivalCity;
  String arrivalBusStop;
  String arrivalTime;
  String tourNumber;
  String date;
  String ticketNumber;
  String bookingNumber;
  String qrCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    passengerName: json["passengerName"],
    seatNu: json["seatNu"],
    departureCity: json["departureCity"],
    departureBusStop: json["departureBusStop"],
    departureTime: json["departureTime"],
    arrivalCity: json["arrivalCity"],
    arrivalBusStop: json["arrivalBusStop"],
    arrivalTime: json["arrivalTime"],
    tourNumber: json["tourNumber"],
    date: json["date"],
    ticketNumber: json["ticketNumber"],
    bookingNumber: json["bookingNumber"],
    qrCode: json["qrCode"],
  );

  Map<String, dynamic> toJson() => {
    "passengerName": passengerName,
    "seatNu": seatNu,
    "departureCity": departureCity,
    "departureBusStop": departureBusStop,
    "departureTime": departureTime,
    "arrivalCity": arrivalCity,
    "arrivalBusStop": arrivalBusStop,
    "arrivalTime": arrivalTime,
    "tourNumber": tourNumber,
    "date": date,
    "ticketNumber": ticketNumber,
    "bookingNumber": bookingNumber,
    "qrCode": qrCode,
  };
}

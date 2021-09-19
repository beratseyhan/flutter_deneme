


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'constan.dart';

import 'module/TicketDetails_Modal.dart';
class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  int _selectedItem = 0;
  var ticketDetailsResult;
  static const String url="https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/bac96e9b-717b-40b5-8198-6bfe84fbe081/ticket";
  Future   getTicketDetails () async{
    try{
      final response =await http.get(Uri.parse(url));
      if(200==response.statusCode){
        var result = ticketDetailsFromJson(response.body);
        print(result.data.arrivalTime);
        if(mounted)
          setState(() {
            ticketDetailsResult=result;

          });
        return result;
      }else {
        print(response.statusCode);
      }

    }catch (e){
      print(e.toString());
    }
  }


  @override
  void initState() {
    getTicketDetails();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(



        body:Container(
          margin: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.089,
            MediaQuery.of(context).size.height * 0.045,
            MediaQuery.of(context).size.width*0.089,
            MediaQuery.of(context).size.height * 0.182,),
          height: MediaQuery.of(context).size.height * 0.523,
          width: MediaQuery.of(context).size.width * 0.82,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // begin: Alignment(0.0, 0.0),
                // end: Alignment(1, 1),
                stops: [0.1,
                  0.5,
                  0.9],
                colors: [
                  Color(0x33FE5301) ,

                  Color(0x00C4C4C4),
                  Color(0xDA2C6BE),
                ],
              )),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10,10,10,10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Departure Time",style: TextStyle(fontSize: 14,color:Color(0xFF939290),fontWeight: FontWeight.w400)
                    ),
                    Text("Arrival Time",style: TextStyle(fontSize: 14,color:Color(0xFF939290),fontWeight: FontWeight.w400)
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ticketDetailsResult.data.departureTime}",style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w500)
                    ),
                    Text("${ticketDetailsResult.data.arrivalTime}",style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w500)
                    ),

                  ],
                ),
                SizedBox(
                  height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ticketDetailsResult.data.departureCity}",style: TextStyle(fontSize: 24,color:kOrange,fontWeight: FontWeight.w700)
                    ),

                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        children: [
                          TextSpan(
                            text:  '            ',
                            style: TextStyle(
                              color: Color(0xFFFE5301),
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.arrow_forward,size: 13, color: Color(0xFFFE5301),),
                          ),
                          TextSpan(
                            text:  '            ',
                            style: TextStyle(
                              color: Color(0xFFFE5301),
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.dashed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text("${ticketDetailsResult.data.arrivalCity}",style: TextStyle(fontSize: 24,color:kOrange,fontWeight: FontWeight.w700)
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ticketDetailsResult.data.departureBusStop}",style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w400)
                    ),


                    Text("${ticketDetailsResult.data.arrivalBusStop}",style: TextStyle(fontSize: 12,color:Colors.black,fontWeight: FontWeight.w400)
                    ),

                  ],
                ),
                SizedBox(
                  height: 23,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Passenger",style: TextStyle(fontSize: 14,color:kTextGrey,fontWeight: FontWeight.w400)
                    ),


                    Text("Seat",style: TextStyle(fontSize: 14,color:kTextGrey,fontWeight: FontWeight.w400)
                    ),

                  ],
                ),
                SizedBox(
                  height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ticketDetailsResult.data.passengerName}",style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w400)
                    ),


                    Container(
                      height: 20,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFFFE5301) ,
                      ),

                      child: Center(
                        child: Text("${ticketDetailsResult.data.seatNu}",style: TextStyle(fontSize: 16,color:Colors.white,fontWeight: FontWeight.w500)
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tour Number",style: TextStyle(fontSize: 14,color:kTextGrey,fontWeight: FontWeight.w400)
                    ),


                    Text("Date",style: TextStyle(fontSize: 14,color:kTextGrey,fontWeight: FontWeight.w400)
                    ),

                  ],
                ),
                SizedBox(
                  height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${ticketDetailsResult.data.tourNumber}",style: TextStyle(fontSize: 16,color:Colors.black,fontWeight: FontWeight.w400)
                    ),


                    Text("${ticketDetailsResult.data.date}",style: TextStyle(fontSize: 16,color:kTextBlack,fontWeight: FontWeight.w500)
                    ),

                  ],
                ),
                SizedBox(
                  height: 4,),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ticket Number",style: TextStyle(fontSize: 14,color:kTextGrey,fontWeight: FontWeight.w400)
                                  ),




                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.005,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${ticketDetailsResult.data.ticketNumber}",style: TextStyle(fontSize: 16,color:kTextBlack,fontWeight: FontWeight.w400)
                                  ),




                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.0075,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Booking Number",style: TextStyle(fontSize: 14,color:kTextGrey,fontWeight: FontWeight.w400)
                                  ),




                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.005,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${ticketDetailsResult.data.bookingNumber}",style: TextStyle(fontSize: 16,color:kTextBlack,fontWeight: FontWeight.w500)
                                  ),




                                ],
                              ),
                            ],
                          ),
                        )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.fromLTRB(60.0,0,0,0),
                      child: Container(


                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.height * 0.05,
                        child:QrImage(
                          data: "${ticketDetailsResult.data.qrCode}",
                          version: QrVersions.auto,
                          size: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                    )),
                  ],
                )

              ],
            ),
          ),



        )
    );
  }
}


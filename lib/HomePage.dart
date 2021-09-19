import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'TicketPage.dart';
import 'constan.dart';

import 'module/FlightChart.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'module/LoginResult_Module.dart';

String userId;
bool showChartSpinner=true;
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
enum SelectedPage {
  Home,
  Ticket,
}


class _HomePageState extends State<HomePage> {

  var email;
  var password;
  bool _loading;
  int chartCounter;
  var chartResult;
  var loginResult;
  bool showSpinner=false;

  List <String> strg;

  SelectedPage  selectedPage=SelectedPage.Home;
  int index = 0;

  @override
  void initState() {


    super.initState();

    _loading=true;

    getChart();

  }



  static const String url="https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/departureTimes";
  Future   getChart () async{
    try{
      final response =await http.get(Uri.parse(url));
      if(200==response.statusCode){
        var result = flightChartFromJson(response.body);
        print(result.data[1].daysOfWeek[1]);
        if(mounted)
          setState(() {
            chartCounter=result.data.length;
            chartResult=result;
            showChartSpinner=false;

          });
        return result;
      }else {
        print(response.statusCode);
      }

    }catch (e){
      print(e.toString());
    }
  }
  Future<void> login() async {

    String loginHttp="https://anybwnk52i.execute-api.eu-central-1.amazonaws.com/test/login";
    if(password!=null&&email!=null){
      var response=   await http.post(Uri.parse(loginHttp),body: {
        'email':email,
        'password':password,
      });
      if(response.statusCode==200){
        var result=await loginResultFromJson(response.body);
        userId=result.data.userId;
        print(result.data.userId);

        setState(()async {


          showSpinner=false;
          Navigator.pop(context);
          SharedPreferences prefs =
          await SharedPreferences.getInstance();
          await prefs.setString('userId', result.data.userId);
          selectedPage=SelectedPage.Ticket;

        });
      }else{
        showSpinner=false;
      }
    }else{


      showSpinner=false;
    }


  }


  @override
  Widget build(BuildContext context) {
    void showCustomDialog(BuildContext context,) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext cxt) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16,135,16,209),
                child: Material(

                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32,horizontal: 0),
                    child: Container(


                      child: Column(

                        children: [
                          Text(
                            _loading?"Loading":'Welcome back!',
                            style: TextStyle(
                              fontWeight: FontWeight.w700, // light
                              fontStyle: FontStyle.normal, //
                              fontSize: 24,// italic
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(vertical:24 ,horizontal: 20),
                            child: TextField_Login(

                              onChangeValue: (value) {
                                email = value;
                              },

                              inputType: TextInputType.emailAddress,
                              fildText: ' E-mail',
                              textSEE: false,
                              TextFieldColor: Colors.white,

                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:0 ,horizontal: 20),
                            child: TextField_Login(
                              onChangeValue: (value) {
                                password= value;
                              },
                              inputType: TextInputType.emailAddress,
                              fildText: 'Password',
                              textSEE: true,
                              TextFieldColor: Colors.white,

                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.073,
                            width: MediaQuery.of(context).size.width * 0.375,

                            margin: EdgeInsets.all(
                                MediaQuery.of(context).size.height * 0.005),
                            child: ElevatedButton(

                              child: Text('LOG IN',style: TextStyle(
                                fontWeight: FontWeight.w700, // light
                                fontStyle: FontStyle.normal, //
                                fontSize: 14,

                              ),),
                              onPressed: () {
                                setState(() {
                                  showSpinner=true;
                                });
                                login();



                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(100.0),
                                ),
                                primary: Color(0xFFFE5301),

                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }


    return chartResult!=null? Scaffold(
      appBar: AppBar(
        title: Text(
          'Test APP ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'FredokaOne',
            fontSize: 18.0,
            letterSpacing: 1.0,
            wordSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.directions_bus,
            color: Colors.white,
            size: 30,

          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFFFE5301),
        elevation: 0.0,
      ),
      body:selectedPage==SelectedPage.Home?HomeWidget(chartCounter: chartCounter, chartResult: chartResult):TicketPage(),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: (){

                print("home");
                setState(() {
                  selectedPage=SelectedPage.Home;

                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.home,
                    color:selectedPage==SelectedPage.Home ?Color(0xFFFE5301)
                        :Color(0xFF323232),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Homescreen",
                    style: TextStyle(
                        color: selectedPage==SelectedPage.Home ?Color(0xFFFE5301)
                            :Color(0xFF323232),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),


            SizedBox(
              width: 51,
            ),
            GestureDetector(
              onTap: (){
                showCustomDialog(context,);
                print("ticket");


              },
              child: Row(
                children: [ Icon(
                  Icons.text_snippet,
                  color:selectedPage==SelectedPage.Ticket ?Color(0xFFFE5301)
                      :Color(0xFF323232),
                ),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Tickets",
                    style: TextStyle(
                        color: selectedPage==SelectedPage.Ticket ?Color(0xFFFE5301)
                            :Color(0xFF323232),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),],
              ),
            )

          ],
        ),
      ),



    ):ModalProgressHUD(
      inAsyncCall: true,
      child: Scaffold( appBar: AppBar(
        title: Text(
          'Test APP ',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'FredokaOne',
            fontSize: 18.0,
            letterSpacing: 1.0,
            wordSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.directions_bus,
            color: Colors.white,
            size: 30,

          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFFFE5301),
        elevation: 0.0,
      ),body: Center(child: Text("Loading"),)),
    );
  }
}

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key key,
    @required this.chartCounter,
    @required this.chartResult,
  }) : super(key: key);

  final int chartCounter;
  final  chartResult;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          right: MediaQuery.of(context).size.height * 0.025,
          left:  MediaQuery.of(context).size.height * 0.025,
          // top: 136,
          // right: 16,
          // left: 16,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.3,
            // height: 173,
            // width: 371,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: const DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1528728329032-2972f65dfb3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=500&q=80"),
                fit: BoxFit.cover,
              ),

              borderRadius: BorderRadius.circular(12),

            ),

            child:   Container(

                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                // padding: new EdgeInsets.fromLTRB(16, 160, 197, 16),
                child: const Align(
                  alignment: Alignment(-0.85, 0.75),
                  child:  Text("Explore our Destinations",style: TextStyle( color: Colors.white,
                    fontFamily: 'FredokaOne',
                    fontSize: 15.0,
                    fontWeight:FontWeight.bold ,
                    letterSpacing: 1.0,
                    wordSpacing: 2.0,),),
                )
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.38,
          left:  MediaQuery.of(context).size.height * 0.025,
          child: Text("Departure Times",style: TextStyle( color: Colors.black,
            fontFamily: 'FredokaOne',
            fontSize: 18.0,
            fontWeight:FontWeight.bold ,
            letterSpacing: 1.0,
            wordSpacing: 2.0,),),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.425,

          child:Container(

            child: ListView.builder(

                itemCount: chartCounter,
                itemBuilder: (BuildContext context,int index){

                  return ListTile(
                    leading: chartResult.data[index].tourType =="Day"? Icon(Icons.wb_sunny,color: kOrange,size: 15.5,):Icon(Icons.bedtime,color: kOrange,size: 15.5,),
                    title: Text("${chartResult.data[index].route} / ${chartResult.data[index].departureTime} - ${chartResult.data[index].arrivalTime}",style: TextStyle(fontSize: 16,color:Color(0xFF292929),fontWeight: FontWeight.w700)),
                    subtitle: Text(
                        '${chartResult.data[index].daysOfWeek[0]} '
                            ' -${chartResult.data[index].daysOfWeek[1]} '
                            '- ${chartResult.data[index].daysOfWeek[2]} '
                            '- ${chartResult.data[index].daysOfWeek[3]} ',

                        style: TextStyle(fontSize: 14,color:Color(0xFF323232),fontWeight: FontWeight.w400)
                    ),
                    // trailing: Icon(Icons.more_vert),
                    isThreeLine: true,
                  );
                }
            ),
            height:  MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width ,
            color: Color(0xFFF7F7F7),

          ),
        ),
      ],
    );
  }
}

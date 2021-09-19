import 'package:get/get.dart';
class GetXHelper extends GetxController{
  int which = 0;
  void checktext(String text)
  {
    if(text.isNum)
    {
      print("${text} is a number");
      which = 1;
    }else if(text.isAlphabetOnly)
    {
      print("${text} is a username");
      which = 2;
    }else if(text.isEmail)
    {
      print("${text} is Email");
      which = 3;
    }
    else if(text.isEmpty)
    {
      which = 0;
    }
    update();
  }
  void login()
  {
    if(which == 1)
    {
      //auth
      print("Run a method from phone number signIn");
    }
    else if(which == 2)
    {
      print("Run a method from Username signIn");
      //auth
    }
    else if(which == 3)
    {
      print("Run a method from Email signIn");//auth
    }
    else{
      print("Show a message to user if textfield is empty");
    }
  }
}
import 'package:healing_hand/PatientPages/PatientSignupPage.dart';
import'package:http/http.dart' as http;
class postApihttp
{
  String baseurl="http://handycraf.000webhostapp.com/helping_hand/";
  int m=0;
  Future<int> givedata(int i) async
    {
      return m; 
      
    }
    
Future saveData4(String email,
      String password,String name,String category,String rating,String address,String gender,String age, ) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseurl+"updatedoctor.php"));
    request.fields.addAll({
      //'name': name,
      //'number': number,
      'address':address,
      'phoneno': remember,
      'password': password,
      'name':name,
      'rating':rating,
      'category':category,
      'gender':gender,
    //  'age':age,
      'email':email   
       });
    String s='''"success"''';
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q=await response.stream.bytesToString();
      
      print(q);
      if(s==q.toString())
      {
        print("bye");
        print(s);
        m=0;
      givedata(0);
      }
      else
      {print("bb");
        m=1;
        givedata(1);
      }
    }
    else {
        m=1;
      print(response.reasonPhrase);
      final g=response.reasonPhrase;
givedata(1); 
      }     

    }
Future saveData2(String email,
      String password,String name,String height,String weight,String gender,String age, ) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseurl+"updateuser.php"));
    request.fields.addAll({
      //'name': name,
      //'number': number,
      'phoneno': remember,
      'password': password,
      'name':name,
      'height':height,
      'weight':weight,
      'gender':gender,
      'age':age,
      'email':email    });
    String s='''"success"''';
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q=await response.stream.bytesToString();
      
      print(q);
      if(s==q.toString())
      {
        print("bye");
        print(s);
        m=0;
      givedata(0);
      }
      else
      {print("bb");
        m=1;
        givedata(1);
      }
    }
    else {
        m=1;
      print(response.reasonPhrase);
      final g=response.reasonPhrase;
givedata(1); 
      }     

    }
  Future saveData3(String email,
      String phone,String purpose,String status,String date,String enddate ) async {
        print(enddate);

    var request = http.MultipartRequest('POST', Uri.parse(baseurl+"updateappoinment.php"));
    request.fields.addAll({
      //'name': name,
      //'number': number,
      'phoneno': phone,
      'umail':email,
      'status':status,
      'date':date,
      'enddate':enddate,
      'purpose':purpose
    });
    String s='''"success"''';
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q=await response.stream.bytesToString();
      
      print(q);
      if(s==q.toString())
      {
        print("bye");
        print(s);
        m=0;
      givedata(0);
      }
      else
      {print("bb");
        m=1;
        givedata(1);
      }
    }
    else {
        m=1;
      print(response.reasonPhrase);
      final g=response.reasonPhrase;
givedata(1); 
      }     

    }
       
  Future saveData1(String email,
      String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseurl+"login1.php"));
    request.fields.addAll({
      //'name': name,
      //'number': number,
      'phoneno': email,
      'password': password
    });
    String s='''"success"''';
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q=await response.stream.bytesToString();
      
      print(q);
      if(s==q.toString())
      {
        print("bye");
        print(s);
        m=0;
      givedata(0);
      }
      else
      {print("bb");
        m=1;
        givedata(1);
      }
    }
    else {
        m=1;
      print(response.reasonPhrase);
      final g=response.reasonPhrase;
givedata(1); 
      }     

    }
    
  Future saveData(String email,
      String password) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseurl+"login1.php"));
    request.fields.addAll({
      //'name': name,
      //'number': number,
      'phoneno': email,
      'password': password
    });
    String s='''"success"''';
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final q=await response.stream.bytesToString();
      
      print(q);
      if(s==q.toString())
      {
        print("bye");
        print(s);
        m=0;
      givedata(0);
      }
      else
      {print("bb");
        m=1;
        givedata(1);
      }
    }
    else {
        m=1;
      print(response.reasonPhrase);
      final g=response.reasonPhrase;
givedata(1); 
      }     

    }
    
}
  

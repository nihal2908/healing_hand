import'package:http/http.dart' as http;
class postApihttp
{
  String baseurl="http://handycraf.000webhostapp.com/helping_hand/";
  int m=0;
  Future<int> givedata(int i) async
    {
      return m; 
      
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
  

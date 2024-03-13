class prodModal3 {
  
   String? user_name;
  String? user_email;
  String? pass;
  String? phone;
  String? weight;
  String? height;
  String? age;
  String? gender;
  prodModal3(
      {
     this.user_name,this.user_email,this.pass,this.phone,this.weight,this.height,this.age,this.gender
      
      });

  prodModal3.fromJson(Map<String, dynamic> json) {

    user_name=json['name'];
    user_email=json['email'];
    pass=json['password'];
    phone=json['phone'];
    weight=json['weight'];
    height=json['height'];
    age=json['age'];
    gender=json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  
  data['email']=user_email;
 data['phoneno']=phone;
 data['name']=user_name;
 data['password']=pass;
 data['weight']=weight;
 data['height']=height;
 data['age']=age;
 data['gender']=gender;   
        return data;
  }
}

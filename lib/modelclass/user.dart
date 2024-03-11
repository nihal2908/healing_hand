class User{
  String? user_name;
  String? user_email;
  String? pass;
  String? phone;
  String? weight;
  String? height;
  String? age;
  String? gender;
  User(this.user_name,this.user_email,this.pass,this.phone,this.weight,this.height,this.age,this.gender)
  {

  }
  Map<String,dynamic> toJson() =>
  {
    'name':user_name.toString(),
    'weight':weight.toString(),
    'email':user_email.toString(),
    'password':pass.toString(),
      'age':age.toString(),
      'gender':gender.toString(),
      'phoneno':phone.toString(),
      'height':height.toString(),
      
  };
  Map<String,dynamic> fromJson(item) =>
  {
    user_name.toString():'name',
    user_email.toString():'email',
    pass.toString():'password',
      phone.toString():'phoneno',
      weight.toString(): 'weight',
      height.toString(): 'height',
      age.toString() :'age',
      gender.toString() :'gender',
    
      
  };
}
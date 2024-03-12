class User{
  String? user_name;
  String? user_email;
  String? pass;
  String? phone;
  String? category;
  String? address;
  String? age;
  String? gender;
  User(this.user_name,this.user_email,this.pass,this.phone,this.category,this.address,this.age,this.gender)
  {

  }
  Map<String,dynamic> toJson() =>
  {
    'name':user_name.toString(),
    'category':category.toString(),
    'email':user_email.toString(),
    'password':pass.toString(),
      'age':age.toString(),
      'gender':gender.toString(),
      'phoneno':phone.toString(),
      'address':address.toString(),
      
  };
  Map<String,dynamic> fromJson(item) =>
  {
    user_name.toString():'name',
    user_email.toString():'email',
    pass.toString():'password',
      phone.toString():'phoneno',
      category.toString(): 'category',
      address.toString(): 'address',
      age.toString() :'age',
      gender.toString() :'gender',
    
      
  };
}
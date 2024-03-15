class prodModal {
  
  String? name;
  String? phone;
  String? email;
  String? category;
  String? address;
  String? gender;
  String? age;
  String? rating; 
  prodModal(
      {
      this.name,
      this.phone,
      this.email,
      this.category,
      this.address,
      this.gender,
      this.age,
      this.rating,
      });

  prodModal.fromJson(Map<String, dynamic> json) {
rating=json['rating'];
phone=json['phoneno'];
    name = json['name'];
    email=json['email'];
    address= json['address'];
   age=json['description'];
    category = json['category'];
    gender=json['gender'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
data['rating']=rating;  
 data['name']=name;
    data['email']=email;
     data['address']=address;
   data['description']=age;
    data['category']=category;
   data['gender']  =gender;
    data['phoneno']= phone;    return data;
  }
}

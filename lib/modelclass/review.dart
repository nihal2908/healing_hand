class prodModal1 {
  
  String? email;
String ?umail;  String? review; 
  prodModal1(
      {
      this.umail,
      this.review,
      this.email,
      
      
      });

  prodModal1.fromJson(Map<String, dynamic> json) {

    email=json['pmail'];
    umail=json['umail'];
    review=json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  
  data['pmail']=email;
 data['umail']=umail;
 data['review']=review;   
        return data;
  }
}

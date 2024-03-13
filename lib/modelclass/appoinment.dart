class prodModal2 {
  
 String? phone;
 String? email;
 String? date;
// String? time;
 String? status; 
String? purpose;
String?enddate;
  prodModal2(
      {
      this.phone,
      this.email,
      this.date,
  //    this.time,
      this.status,
      this.purpose,
      this.enddate,
      });

  prodModal2.fromJson(Map<String, dynamic> json) {
enddate=json['enddate'];
    phone= json['phoneno'];
    email=json['umail'];
    date= json['date'];
   //time=json['time'];
    status = json['status'];
    purpose=json['purpose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
 data['umail']=email.toString();
  data['enddate']=enddate.toString();
 
 data['phoneno']=phone.toString();
 data['date']=date.toString();
 //data['time']=time.toString();
 data['status']=status.toString();
data['purpose']=purpose.toString();
     return data;
  }
}

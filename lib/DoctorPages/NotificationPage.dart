import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/apiconnection/doctorhttp.dart';
import 'package:healing_hand/apiconnection/doctorview.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/modelclass/appoinment.dart';
String? date;
String? time;
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}
httpServices13 http=new httpServices13();
class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<prodModal2>>(
      future: http.getAllPost2(""),
      builder: ((context, snapshot) {
        print("calm down");
        // print(key);
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Scaffold(
              body:
                  Center(heightFactor: 1.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.waiting:
            return Scaffold(
              body:
                  Center(heightFactor: 0.4, child: CircularProgressIndicator()),
            );
          case ConnectionState.active:
          if(snapshot.data!=null)
            //return CircularProgressIndicator();
            return ShowPostList(context, snapshot.data!);
            else
            return CircularProgressIndicator();
          case ConnectionState.done:
          if(snapshot.data!=null)
            //return CircularProgressIndicator();
            return ShowPostList(context, snapshot.data!);
            else
            return CircularProgressIndicator();
        }
        //}

        //else{
        //return CircularProgressIndicator();
        //}

        //  return CircularProgressIndicator();
      }),
    );
  }
  Widget ShowPostList(BuildContext context,List<prodModal2> posts)
  {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: Text('Notifications'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index){
                if(posts[index].status == "wait")
                  return Column(
                    children: [
                      WhiteContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                                title: Text(posts[index].phone.toString()),
                                subtitle: Text(posts[index].purpose.toString()),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async{
                                        DateTime d=DateTime.now();
                                        String newdate=d.toString();
                                        print("hikbye");
                                        print(d);
                                         postApihttp http=postApihttp();
                                          await http.saveData3(posts[index].email.toString(), posts[index].phone.toString(), posts[index].purpose.toString(), "denied", newdate.toString(), newdate.toString());
                                          
                                        setState(() {
                                         //appointments[index].status = 'denied';
                                        });
                                      },
                                      child: Text('Deny', style: TextStyle(color: Colors.red),)
                                  ),
                                  ElevatedButton(
                                      onPressed: () async{ // update the date, time, status of appointment
                                        selectDateTime(index,posts[index]); //for testing, i am using appointements list and passing index to change that Appointment
                                   
                                      },
                                      child: Text('Accept', style: TextStyle(color: Colors.green),)
                                  ),
                                ],
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 7,)
                    ],
                  );
                else
                  return Container();
              },
              itemCount: posts.length
          ),
        ),
      ),
    );
  }

  void selectDateTime(int index,prodModal2 posts) async {
    showDialog(
        context: context,
        builder: (context){
          DateTime? pickedDate;
          TimeOfDay? pickedStartTime;
          TimeOfDay? pickedEndTime;
          return StatefulBuilder(
              builder: (context, boxState) {
                return AlertDialog(
                  title: Text('Select Date and Time'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Date: ${pickedDate!=null ? '${pickedDate!.day.toString().padLeft(2, '0')}-${pickedDate!.month.toString().padLeft(2, '0')}-${pickedDate!.year}' : 'Not Selected'}'),
                      Text('Start Time: ${pickedStartTime!=null ? '${pickedStartTime!.hour.toString().padLeft(2, '0')}:${pickedStartTime!.minute.toString().padLeft(2, '0')}' : 'Not Selected'}'),
                      Text('End Time: ${pickedEndTime!=null ? '${pickedEndTime!.hour.toString().padLeft(2, '0')}:${pickedEndTime!.minute.toString().padLeft(2, '0')}':'Not Selected'}'),
                      ElevatedButton(
                          onPressed: ()async {
                            pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2024, 12, 30),
                            );
                            if (pickedDate != null) {
                              pickedStartTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickedStartTime != null) {
                                pickedEndTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedEndTime != null) {
                                  boxState(() {});
                                }
                              }
                            }
                          },
                          child: Text('Select')
                      )
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Cancel', style: TextStyle(color: Colors.red),)
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if(pickedDate!=null && pickedStartTime!=null && pickedEndTime!=null){
                             date = DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day, pickedStartTime!.hour, pickedStartTime!.minute).toString();
                             time = DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day, pickedEndTime!.hour, pickedEndTime!.minute).toString();
                            print(date);
                            
                            print(time);

                            // this setstate is only for testing,,, remove it and take the date String, time String above
                            setState(() {
                              appointments[index].date = pickedDate!;
                              appointments[index].startTime = pickedStartTime!;
                              appointments[index].endTime = pickedEndTime!;
                              appointments[index].status = 'accepted';
                            });
                               postApihttp http=postApihttp();
                                     
                                     await  http.saveData3(posts.email.toString(), posts.phone.toString(), posts.purpose.toString(), "accepted", date.toString(), time.toString());
                                          
                            Navigator.pop(context);
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Select Date and Time...')
                                )
                            );
                          }
                        },
                        child: Text('Accept', style: TextStyle(color: Colors.green),)
                    ),
                  ],
                );
              }
          );
        }
    );
  }

}

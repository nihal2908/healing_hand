import 'package:flutter/material.dart';
import 'package:healing_hand/Providers/AppointmentProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
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
                if(appointments[index].status == 'waiting')
                  return Column(
                    children: [
                      WhiteContainer(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                                title: Text(appointments[index].patient.name),
                                subtitle: Text(appointments[index].purpose),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: (){
                                        setState(() {
                                          appointments[index].status = 'denied';
                                        });
                                      },
                                      child: Text('Deny', style: TextStyle(color: Colors.red),)
                                  ),
                                  ElevatedButton(
                                      onPressed: (){ // update the date, time, status of appointment
                                        selectDateTime(index); //for testing, i am using appointements list and passing index to change that Appointment
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
              itemCount: appointments.length
          ),
        ),
      ),
    );
  }

  void selectDateTime(int index) async {
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
                            String date = DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day, pickedStartTime!.hour, pickedStartTime!.minute).toString();
                            String time = DateTime(pickedDate!.year, pickedDate!.month, pickedDate!.day, pickedEndTime!.hour, pickedEndTime!.minute).toString();
                            print(date);
                            print(time);

                            // this setstate is only for testing,,, remove it and take the date String, time String above
                            setState(() {
                              appointments[index].date = pickedDate!;
                              appointments[index].startTime = pickedStartTime!;
                              appointments[index].endTime = pickedEndTime!;
                              appointments[index].status = 'accepted';
                            });
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:healing_hand/customWidgets/WhiteContainer.dart';
import 'package:healing_hand/firebase/AppointmentFunctions.dart';
import 'package:healing_hand/firebase/AuthServices.dart';

class DoctorViewPage extends StatefulWidget {
  final String uid;
  DoctorViewPage({super.key, required this.uid});

  @override
  State<DoctorViewPage> createState() => _DoctorViewPageState(uid: uid);
}

class _DoctorViewPageState extends State<DoctorViewPage> {
  _DoctorViewPageState({required this.uid});
  final String uid;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController reviewController = TextEditingController();
  double userRating = 0.0;
  bool _showAllReviews = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: firestore.collection('Doctor').doc(uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // Or any other loading indicator
          }
          var doctor = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100,),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                //height: 250,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30,),
                                    Text(doctor['name'], style: nameSytle,),
                                    Text(doctor['category'], style: profileStyle),
                                    Text(doctor['bio'], style: profileStyle),
                                    Text('${doctor['age']} years', style: profileStyle,),
                                    Text(doctor['gender'], style: profileStyle),
                                    Text(doctor['email'], style: profileStyle),
                                    Text(doctor['address'], style: profileStyle),
                                    RatingBar.builder(
                                      initialRating: doctor['rating'],
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 25,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      ignoreGestures: true,
                                      onRatingUpdate: (_) {},
                                    ),
                                    Text('${doctor['rating']} / 5', style: profileStyle),
                                    //Text('${PatientUser.height}cm / ${PatientUser.weight}Kg', style: profileStyle)
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      const SizedBox(height: 20,),
                      WhiteContainer(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Customer reviews', style: nameSytle,),
                            ElevatedButton(
                              onPressed: () {
                                showReviewDialog();
                              },
                              child: Text('Add Your Review'),
                            ),
                            StreamBuilder(
                              stream: firestore.collection('Review').doc(uid).collection('reviews').snapshots(),
                              builder: (context, reviewSnapshot) {
                                if (reviewSnapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (reviewSnapshot.hasError) {
                                  return Center(child: Text('Error: ${reviewSnapshot.error}'));
                                }

                                if (!reviewSnapshot.hasData || reviewSnapshot.data!.docs.isEmpty) {
                                  return Center(child: Text('No reviews to show.'));
                                }

                                var reviews = reviewSnapshot.data!.docs.map((reviewDoc) {
                                  var reviewData = reviewDoc.data() as Map<String, dynamic>;
                                  return ListTile(
                                    title: Text(reviewData['patient']),
                                    subtitle: Column(
                                      children: [
                                        Text(reviewData['review']),
                                        RatingBar.builder(
                                          initialRating: reviewData['rating'],
                                          //minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 10,
                                          itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          ignoreGestures: true,
                                          onRatingUpdate: (_){},
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList();

                                if (!_showAllReviews && reviews.length > 1) {
                                  reviews = [reviews.last];
                                  reviews.add(
                                    ListTile(
                                      title: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _showAllReviews = true;
                                          });
                                        },
                                        child: Text('Show All Reviews (${reviewSnapshot.data!.docs.length})'),
                                      ),
                                    ),
                                  );
                                }

                                return Column(children: reviews);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 67,
                        child: Center(
                            child: Text(
                                doctor['name'],
                                style: titleStyle
                            )
                        ),
                      ),
                      CircleImage(image: AssetImage('assets/images/doctor.png')),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(3),
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )
          ),
          onPressed: () {
            showAppointmentDialog(uid: uid);
          },
          child: Text('Get an Appointment'),
        ),
      ),
    );
  }

  void showAppointmentDialog({required String uid}){
    TextEditingController purposeController = TextEditingController();
    TextEditingController modeController = TextEditingController();
    showDialog(context: context, builder: (context)=>
        AlertDialog(
          title: Text('Enter purpose and Mode(Online/Offline)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: purposeController,
                decoration: InputDecoration(
                    hintText: 'Purpose'
                ),
              ),
              TextField(
                controller: modeController,
                decoration: InputDecoration(
                    hintText: 'Mode'
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text('Cancel')
            ),
            TextButton(
                onPressed: (){
                  createAppointment(
                      patient: currentUserId,
                      doctor: uid,
                      status: 'waiting',
                      mode: modeController.text,
                      purpose: purposeController.text,
                  );
                  Navigator.pop(context);
                },
                child: Text('Send Request')
            ),
          ],
        )
    );
  }

  void showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Review, Rating'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Give rating:'),
                  RatingBar.builder(
                    initialRating: userRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newRating) {
                      setState(() {
                        userRating = newRating;
                      }); // the value of the rating given by user is stored in userRating value, use it
                    },
                  ),
                ],
              ),
              TextField(
                controller: reviewController,
                decoration: InputDecoration(hintText: 'Enter your review'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addReview(reviewController.text);
                Navigator.pop(context);
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }
  // void _addReview() {
  //   String reviewText = '${PatientUser.name}: "${reviewController.text}"';
  //   setState(() {
  //     if (doc.reviews != null) {
  //       doc.reviews!.add(reviewText);
  //     }
  //     else {
  //       doc.reviews = ['${reviewController.text}'];
  //     }
  //     reviewController.clear();
  //   }
  //   );
  // }

  Future<void> addReview(String text) async {
    await firestore
        .collection('Review')
        .doc(uid)
        .collection('reviews')
        .add({
      'patient': 'Anonymous',
      'review': text
    });
  }

}

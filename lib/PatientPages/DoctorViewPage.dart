import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/Providers/PatientProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:provider/provider.dart';

class DoctorViewPage extends StatefulWidget {
  final Doctor doc;
  DoctorViewPage({super.key, required this.doc});

  @override
  State<DoctorViewPage> createState() => _DoctorViewPageState(doc: doc);
}

class _DoctorViewPageState extends State<DoctorViewPage> {
  final Doctor doc;
  _DoctorViewPageState({required this.doc});
  bool showAllReviews = false;
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    bool noReview = (doc.reviews == null);

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
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
                                      Text(doc.name, style: nameSytle,),
                                      Text(doc.category, style: profileStyle),
                                      Text('${doc.age} years', style: profileStyle,),
                                      Text(doc.gender, style: profileStyle),
                                      Text(doc.email, style: profileStyle),
                                      RatingBar.builder(
                                        initialRating: doc.rating,
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
                                        onRatingUpdate: (newRating) {
                                          setState(() {
                                            doc.rating = newRating;
                                          });
                                        },
                                      ),
                                      Text('${doc.rating} / 5', style: profileStyle),
                                      //Text('${PatientUser.height}cm / ${PatientUser.weight}Kg', style: profileStyle)
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          //height: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Customer reviews', style: nameSytle,),
                                  if (widget.doc.reviews!.length > 2)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        showAllReviews = !showAllReviews;
                                      });
                                    },
                                    child: Text(showAllReviews ? 'Hide' : 'See all'),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //height: 150,
                                child: Column(
                                  children: [
                                    noReview? Padding(padding: EdgeInsets.all(10), child: Text('No recent Reviews')):
                                    Column(
                                      children: [
                                        // Display two recent reviews
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: showAllReviews ? doc.reviews!.length : doc.reviews!.length>=2 ? 2 : doc.reviews!.length,
                                          itemBuilder: (context, index) {
                                            String review = doc.reviews![index];
                                            List<String> parts = review.split(': ');

                                            return ListTile(
                                              title: Text(parts[0]),
                                              subtitle: Text(parts[1]),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showReviewDialog();
                                      },
                                      child: Text('Add Your Review'),
                                    ),
                                  ],
                                )

                              )
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
                                  doc.name,
                                  style: titleStyle
                              )
                          ),
                        ),
                        CircleImage(imagePath: 'assets/images/demo_user.jpg'),
                      ],
                    ),
                  ],
                ),
              ),
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
            print('Appoint book');
          },
          child: Text('Get an Appointment'),
        ),
      ),
    );
  }

  void showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Review'),
          content: TextField(
            controller: reviewController,
            decoration: InputDecoration(hintText: 'Enter your review'),
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
                _addReview();
                Navigator.pop(context);
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }
  void _addReview() {
    String reviewText = '${PatientUser.name}: "${reviewController.text}"';
    setState(() {
      if (doc.reviews != null) {
        doc.reviews!.add(reviewText);
      }
      else {
        doc.reviews = ['${reviewController.text}'];
      }
      reviewController.clear();
    }
    );
  }
}

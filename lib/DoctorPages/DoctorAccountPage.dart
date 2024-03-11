import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:healing_hand/PatientPages/PatientAccountPage.dart';
import 'package:healing_hand/Providers/DoctorProvider.dart';
import 'package:healing_hand/customWidgets/CircleImage.dart';
import 'package:provider/provider.dart';

class DoctorAccountPage extends StatefulWidget {
  final Doctor doc;
  DoctorAccountPage({super.key, required this.doc});

  @override
  State<DoctorAccountPage> createState() => _DoctorAccountPageState(doc: doc);
}

class _DoctorAccountPageState extends State<DoctorAccountPage> {
  final Doctor doc;
  _DoctorAccountPageState({required this.doc});
  bool showAllReviews = false;

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
                                  ignoreGestures: true,
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (newRating) {
                                    setState(() {
                                      doc.rating = newRating;
                                    });
                                  },
                                ),
                                Text('${doc.rating} / 5', style: profileStyle),
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
                              ],
                            )

                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: InkWell(
                        onTap: (){
                          print('Change password');
                        },
                        child: Center(child: Text('Change Password', style: nameSytle,))
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(25)
                    ),
                    child: InkWell(
                        onTap: (){
                          print('Logout pressed');
                        },
                        child: Center(child: Text('Log-out', style: nameSytle,))
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 67,
                    child: Center(
                        child: Text(
                            'Your Profile',
                            style: titleStyle
                        )
                    ),
                  ),
                  CircleImage(imagePath: 'assets/images/doctor.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

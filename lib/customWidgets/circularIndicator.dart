import 'package:flutter/material.dart';

void showCircularProgressIndicator(BuildContext context){
  showDialog(context: context, builder: (context){
    return Center(
      child: CircularProgressIndicator(),
    );
  });
}
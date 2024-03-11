import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode thememode = ThemeMode.system;
  int thememodeindex = 2;
  List<ThemeMode> thememodes = [ThemeMode.light, ThemeMode.dark, ThemeMode.system];

  void changeThemeMode(int index) async {
    thememodeindex = index;
    thememode = thememodes[index];
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeindex', thememodeindex);
  }

  void getThememode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? gottheme = prefs.getInt('themeindex');
    if(gottheme == null){
      thememodeindex = 2;
    }
    else{
      thememodeindex = gottheme;
    }
  }
}
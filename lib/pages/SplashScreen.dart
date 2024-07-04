import 'package:flutter/material.dart';
import 'package:healing_hand/DoctorPages/DoctorLandingPage.dart';
import 'package:healing_hand/PatientPages/PatientLandingPage.dart';
import 'package:healing_hand/firebase/user_manager.dart';
import 'package:healing_hand/pages/OnBoardingPage.dart';
import 'package:healing_hand/services/connection_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;
  String? _errorMessage;
  final ConnectivityService _connectivityService = ConnectivityService();

  @override
  void initState() {
    super.initState();
    _checkNetworkConnection();
  }

  Future<void> _checkNetworkConnection() async {
    bool hasConnection = await _connectivityService.checkConnection();
    if (hasConnection) {
      _initializeUser();
    } else {
      _showNoConnectionDialog();
    }
  }

  Future<void> _initializeUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await UserManager.initializeApp();
      if (UserManager.userId == null) {
        // Navigate to login screen if there is no logged-in user
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingPage()),
        );
      } else {
        // Navigate to the appropriate screen based on user type
        if(UserManager.userType == 'Patient') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PatientLandingPage()),
          );
        }
        else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DoctorLandingPage()),
          );
        }
        return;
      }
    } catch (e) {
      print('An error occurred: $e');
      setState(() {
        _errorMessage = 'Failed to retrieve user data. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(_errorMessage ?? 'An unknown error occurred.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _initializeUser(); // Retry
                },
                child: const Text('Retry'),
              ),
            ],
          );
        },
      );
    });
  }

  void _showNoConnectionDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your internet connection and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _checkNetworkConnection(); // Retry
                },
                child: const Text('Retry'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_errorMessage != null) {
      _showErrorDialog();
      return const Scaffold(
        body: Center(
          child: Text('An error occurred.'),
        ),
      );
    } else {
      // This state should not be reached due to navigation logic above
      return const Scaffold(
        body: Center(
          child: Text('Unexpected state.'),
        ),
      );
    }
  }
}

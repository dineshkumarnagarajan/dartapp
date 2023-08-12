import 'package:flutter/material.dart';
import 'components/layout/drawer.dart';



class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to the HomeScreen
            Navigator.of(context).pushReplacementNamed('/home');
          },
          child: Text('Go back to Home'),
        ),
      ),
      drawer: DrawerCommon()
    );
  }
}
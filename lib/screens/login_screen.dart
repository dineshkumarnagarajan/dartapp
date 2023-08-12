import 'package:dartapp/screens/home_screen.dart';
import 'package:dartapp/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool shouldDisplayWidget = false;
  String _usernameError = '';
  String _passwordError = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    setState(() {
      _usernameError = '';
      _passwordError = '';
    });

    // Create a map with the data to be sent in the POST request
    Map<String, String> data = {
      'email': username,
      'password': password,
    };

    // Convert the map to a JSON string
    String jsonData = json.encode(data);

    // Set the request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Make the HTTP POST request
    try {
      final response = await http.post(
        Uri.parse(
            'https://demo.creativebees.in/novigradus_crm_api/auth/login'), // Replace with your API URL
        headers: headers,
        body: jsonData,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody['status']);
      if (username.isEmpty) {
        setState(() {
          _usernameError = 'Username is required';
        });
        return;
      }

      if (password.isEmpty) {
        setState(() {
          _passwordError = 'Password is required';
        });
        return;
      }
      if (responseBody['status'] == 200) {
        // Request successful, handle the response data
        print('Login successful! Response: ${response.body}');
        setState(() {
          shouldDisplayWidget = false;
        });

        // Navigate to the HomeScreen
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        shouldDisplayWidget = true;
        _showErrorDialog("Wrong Crentials Try again");
        return;
        // Request failed, handle the error
        print('Failed to login. Status Code: ${response.statusCode}');
        // TODO: Implement error handling logic
      }
    } catch (error) {
      // Error occurred during the request
      print('Error: $error');
      // TODO: Implement error handling logic
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No User Found!'),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, Login to Start'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', width: 200),
            SizedBox(height: 20),
            Text(
              _usernameError,
              style: TextStyle(color: Colors.red),
            ),
            _buildUsernameField(),
            SizedBox(height: 10),
            _buildPasswordField(),
            Text(
              _passwordError,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _usernameController,
        decoration: InputDecoration(
          labelText: 'Username',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

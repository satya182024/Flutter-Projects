import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_page.dart';
import 'main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _message = '';

  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }

// ...

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get the user ID
      String userId = userCredential.user?.uid ?? '';

      // Fetch user data from Firestore
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Access user data
      String userName = userSnapshot[
          'name']; // Replace 'name' with the actual field in your Firestore document

      _showMessage('Welcome back, $userName!');

      // Redirect to the main page with user details
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            userName: userName,
            userEmail:
                _emailController.text, // Pass the email as well if needed
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showMessage('Login failed: ${e.message}');
    }
  }

  void _goToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('E-Ticket App')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60.0), // Add padding to the top
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to E-Ticket App',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/taj.jpg'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              SizedBox(height: 8.0),
              // Text(
              //   _message,
              //   style: TextStyle(
              //     color: Colors.red,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // TextButton(
              //   onPressed: () {
              //     // Implement forgot password functionality
              //   },
              //   child: Text('Forgot Password?'),
              // ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: _goToSignup,
                child: Text('Don\'t have an account? Sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

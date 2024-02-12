import 'package:flutter/material.dart';

void main() {
  runApp(login_page());
}

class login_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LLoginScreen1(),
    );
  }
}

class LLoginScreen1 extends StatefulWidget {
  const LLoginScreen1({Key? key}) : super(key: key);

  @override
  _LLoginScreen1State createState() => _LLoginScreen1State();
}

class _LLoginScreen1State extends State<LLoginScreen1> {
  @override
  Widget build(BuildContext context) {
    final TextField emailField = TextField(
      style: const TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Email',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final TextField passwordField = TextField(
      obscureText: true,
      style: const TextStyle(fontSize: 20.0),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final Material loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: const Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 48.0),
          emailField,
          const SizedBox(height: 24.0),
          passwordField,
          const SizedBox(height: 36.0),
          loginButton,
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

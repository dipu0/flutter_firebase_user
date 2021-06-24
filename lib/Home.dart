import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_user/LogScreen/login.dart';
import 'package:flutter_firebase_user/auth_provider.dart';

class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String email= FirebaseAuth.instance.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
            //sign out user
            AuthClass().signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()),(route)=> false );
          })
        ],
      ),
      body: Center(
        child: Text("Email $email"),
      ),
    );
  }
}

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
  String name= FirebaseAuth.instance.currentUser.displayName;
  String email= FirebaseAuth.instance.currentUser.email;
  String photoURL= FirebaseAuth.instance.currentUser.photoURL;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(photoURL),
                      fit: BoxFit.fill
                  ),
                ),
            ),
            Text("Name: $name\n"+"Email $email\n"),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_user/Home.dart';

import '../auth_provider.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _email =TextEditingController();
  TextEditingController _password =TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Register'),
      ),
      body: isLoading == false ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _email,
              decoration:  const InputDecoration(
                labelText: 'Email',
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.email)),
              ),
            ),

            const SizedBox(height: 30,),

            TextFormField(
              controller: _password,
              decoration:  const InputDecoration(
                labelText: 'Password',
                icon: const Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: const Icon(Icons.lock)),
              ),
              obscureText: true,
            ),
            FlatButton(
              color: Colors.blue,
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  AuthClass().createAccount(email: _email.text.trim(), password: _password.text.trim()).then((value){
                    if(value=='Account Created'){
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()),(route)=> false );
                    } else{
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                    }
                  });
                }, child: Text('Create Account')
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));

              },
              child: Text('Already have an account? Login'),
            ),
            const SizedBox( height: 20, ),
            // Social Media Auth Buttons
            Column(
              children: [
                GestureDetector(
                  onTap: (){
                    //google login
                    AuthClass().signInWithGoogle().then((UserCredential value ){
                      final displayName = value.user.displayName;
                      print(displayName);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> HomePage()), (route) =>false );
                    });
                  },
                  child: Container(
                    color: Colors.yellow,
                    padding: const EdgeInsets.all(10),
                    child: Text("Google"),
                  ),
                ),
                const SizedBox(height: 10,),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    color: Colors.blue.shade900,
                    padding: const EdgeInsets.all(10),
                    child: Text("Facebook",style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal),),
                  ),
                ),
              ],
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator(),)
    );
  }
}

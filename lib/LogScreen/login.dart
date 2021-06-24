import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_user/Home.dart';
import 'package:flutter_firebase_user/LogScreen/register.dart';
import 'package:flutter_firebase_user/LogScreen/reset.dart';
import 'package:flutter_firebase_user/auth_provider.dart';

class LoginPage extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email =TextEditingController();
  TextEditingController _password =TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Login'),
      ),
      body: isLoading == false? Padding(
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
                  AuthClass().signIn(email: _email.text.trim(), password: _password.text.trim()).then((value){
                    if(value=='Welcome'){
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
                }, child: Text('Login Account')
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()));

              },
              child: Text("Don't have any account? Register"),
            ),
            const SizedBox(height: 30,),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPage()));

              },
              child: Text('Forget password? reset'),
            ),
          ],
        ),
      ): Center( child: CircularProgressIndicator(),),
    );
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_provider.dart';
import 'login.dart';

class ResetPage extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);

  @override
  _ResetPageState createState() => _ResetPageState();

}

class _ResetPageState extends State<ResetPage> {
  TextEditingController _email =TextEditingController();
  bool  isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

        title: Text('Reset'),
      ),
      body:  isLoading == false ? Padding(
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
            FlatButton(
                color: Colors.blue,
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  AuthClass().resetPassword(email: _email.text.trim()).then((value){
                    if(value=='Email Send'){
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ResetPage()),(route)=> false );
                    } else{
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                    }
                  });
                }, child: Text('Reset Account')
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));

              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ) : Center(child: CircularProgressIndicator(),)
    );
  }
}

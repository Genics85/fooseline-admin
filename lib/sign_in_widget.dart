import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'app_text.dart';

class SignInPageWidget extends StatefulWidget {
  const SignInPageWidget({Key? key}) : super(key: key);

  @override
  _SignInPageStateWidget createState() => _SignInPageStateWidget();
}

class _SignInPageStateWidget extends State<SignInPageWidget> {

  TextEditingController _username=TextEditingController();
  TextEditingController _password=TextEditingController();

  Future signIn()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _username.text.trim(),
        password: _password.text.trim()
    );
    valueReset();
  }
  valueReset(){
    setState(() {
      _username.text="";
      _password.text="";
    });
  }

  double textFieldHeight=50;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            child:SingleChildScrollView(
              child: Form(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:AssetImage("images/signinLogo.png"),
                              fit:BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.grey,width: 2
                            )
                        ),
                        height: textFieldHeight,
                        margin: const EdgeInsets.only(top:20),
                        child: TextFormField(
                          // validator: _validateInputs,
                            keyboardType: TextInputType.text,
                            controller: _username,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.email),
                              hintText: "Enter Email",
                              // hintStyle: TextStyle(color: hintColor)
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: Colors.grey,width: 2
                            )
                        ),
                        height: textFieldHeight,
                        margin: const EdgeInsets.only(top:20),
                        child: TextFormField(
                          // validator: _validateInputs,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            controller: _password,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Enter Password",
                              // hintStyle: TextStyle(color: hintColor)
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: signIn,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent,
                            minimumSize: Size(200,40),
                          ),
                          child: AppText(text:"Sign In",color: Colors.black,)
                      )
                    ],
                  ),
                ),
              ),
            )
        ),
      );



  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              margin: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.grey
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.person),
                            labelText: "Name",
                            hintText: "Enter Name",
                            // hintStyle: TextStyle(color: hintColor)
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:20),
                      child: TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.email),
                            labelText: "Amount",
                            hintText: "Enter the amount",
                            // hintStyle: TextStyle(color: hintColor)
                          )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );


  }
}

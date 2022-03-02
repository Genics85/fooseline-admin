import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double textFieldHeight=50;
  String dropDownSizeValue="L";
  String dropDownGenderValue="Male";

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
                      height: textFieldHeight,
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.people),
                            labelText: "Name",
                            hintText: "Enter Name",
                            // hintStyle: TextStyle(color: hintColor)
                          )),
                    ),
                    Container(
                      height: textFieldHeight,
                      margin: EdgeInsets.only(top:20),
                      child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            prefixIcon: Icon(Icons.money),
                            labelText: "Price",
                            hintText: "Enter The Price",
                            // hintStyle: TextStyle(color: hintColor)
                          )),
                    ),
                    const SizedBox(height:20),

                      Container(
                        height: textFieldHeight,
                        padding: EdgeInsets.only(left: 10,right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,width: 2
                          )
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                          value: dropDownSizeValue,
                          icon: const Icon(Icons.expand_more),
                          elevation: 16,
                          style: const TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownSizeValue = newValue!;
                            });
                          },
                          items: <String>['L','S', 'XL', 'XXL']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                        ),
                      ),
                        Container(
                          height: textFieldHeight,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.grey,width: 2
                            )
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropDownGenderValue,
                              icon: const Icon(Icons.expand_more),
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownGenderValue = newValue!;
                                });
                              },
                              items: <String>['Unisex','Male', 'Female', 'Kids']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        )
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

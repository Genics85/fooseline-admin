import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooseonline_admin/app_text.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController name= TextEditingController();
  TextEditingController price= TextEditingController();
  double textFieldHeight=50;
  String dropDownSizeValue="L";
  String dropDownGenderValue="Male";

  File? image;

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);

      setState(() {
        this.image = imageTemporary;
      });
    }on PlatformException catch (e){
      print("access to gallery denied $e");
    }
  }

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

                    GestureDetector(
                      onTap: pickImage,
                      child:ClipOval(
                        child: Container(
                          height: 100,
                          width: 100,
                          child: image!=null? Image.file(image!):
                          Image(image: AssetImage("images/cameraLogo.jpg")),
                        ),
                      )
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.grey,width: 2
                        )
                      ),
                      height: textFieldHeight,
                      margin: EdgeInsets.only(top: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: name,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.people),
                            hintText: "Enter Name",
                            border: InputBorder.none,
                              focusColor: Colors.grey
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
                        keyboardType: TextInputType.number,
                        controller: price,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.money),
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
                        ),
                    SizedBox(height: 20,),


                    GestureDetector(
                      onTap: (){
                        FirebaseFirestore.instance.collection("posts").add(
                          {
                            "name":name.text,
                            "price":price.text,
                            "sex":dropDownGenderValue,
                            "size":dropDownSizeValue
                          }
                        ).then((value) => print("cloth added"))
                        .catchError((e)=> print("failed $e"));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: textFieldHeight,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: AppText(text: "Add", color: Colors.white,size: 20,),
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

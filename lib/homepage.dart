import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooseonline_admin/app_text.dart';
import 'package:fooseonline_admin/firebase_post.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController name= TextEditingController();
  TextEditingController price= TextEditingController();
  double textFieldHeight=50;
  String dropDownSizeValue="L";
  String dropDownGenderValue="Male";

  // text fields validator
  String? _validateInputs(String? input) {
    // 2
    if (input!.isEmpty) {
      return 'Field cant be null';
    } else {
      return '';
    }
  }

// Function for picking image from the gallery
  File? _image;
  Future pickImage() async{
    try{
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage == null) {
        return;
      }
      setState(() {
        _image = File(pickedImage.path);
      });

    }on PlatformException catch (e){
      print("access to gallery denied $e");
    }
  }
  // parameters reset after an upload
  reset(){
    setState(() {
      name.text="";
      price.text="";
      _image=null;
    });
  }

//function for text field and image verification before uploading
  bool verifier(){
    return (name.text==""||price.text==""||_image==null);
  }
//function which returns either an upload dialog box or stoping dialog box when a field is empty
  Object add(BuildContext context){

    return (
    verifier()?
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  AlertDialog(
            title: const Text("Uploading an empty field"),
            content: const Text("Make sure all fields are filled"),
            actions: [
              Container(
                margin:const EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child:const AppText(text: "Go back",color: Colors.red,),
                ),
              )
            ],
          );
        }
    ): showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                title: const Text("Uploading now"),
                content: const Text("Do you wish to continue?"),
                actions:[
                  Container(
                    margin:const EdgeInsets.only(left: 15,right: 15),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap:(){

                            Navigator.pop(context);

                            FirebasePost(size: dropDownSizeValue,
                            image: _image,
                            gender: dropDownGenderValue,
                            name: name.text,
                            price: price.text).uploadPhoto().then((value)=>_scaffoldKey.currentState?.
                            showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.greenAccent,
                                    content: AppText(text:"Image successfully added",color: Colors.black,),
                                    duration: Duration(seconds: 2)
                                )
                            ));

                            // reset some parameters after an upload
                            reset();

                          },
                          child: const AppText(text:"Continue",color: Colors.black,),
                        ),
                        InkWell(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: const AppText(text:"Cancel", color: Colors.red,),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
        )

    );
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                margin: const EdgeInsets.all(20),
                child: Form(
                  key: _key,
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: pickImage,
                        child:ClipOval(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: _image!=null? Image.file(_image!):
                            const Image(image: AssetImage("images/cameraLogo.jpg")),
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
                        margin: const EdgeInsets.only(top: 20),
                        child: TextFormField(
                          autofocus: false,
                          validator: _validateInputs,
                          keyboardType: TextInputType.text,
                          controller: name,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.description),
                              hintText: "Enter description",
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
                          validator: _validateInputs,
                          keyboardType: TextInputType.number,
                          controller: price,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.money),
                              hintText: "Enter Price",
                              // hintStyle: TextStyle(color: hintColor)
                            )),
                      ),
                      const SizedBox(height:20),

                        Container(
                          height: textFieldHeight,
                          padding: const EdgeInsets.only(left: 10,right: 10),
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
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 20),
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
                      const SizedBox(height: 20,),


                      GestureDetector(
                        onTap: (){
                          //function for adding product to the backend
                          add(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: textFieldHeight,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: const AppText(text: "Add", color: Colors.white,size: 20,),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

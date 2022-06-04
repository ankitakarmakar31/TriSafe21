//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down_syndrome/Screens/MedicalProfile.dart';
import 'package:flutter/material.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

final controllerPName = TextEditingController();
final controllerGName = TextEditingController();
final controllerGender = TextEditingController();
final controllerAge = TextEditingController();
final controllerLang = TextEditingController();
final controllerAddr = TextEditingController();
final controllerPhone = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Profile"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .02,
              ),
              Image.asset(
                'Assets/Images/userprofile.jfif',
                width: 250,
                height: 180,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                controller: controllerPName,
                decoration: const InputDecoration(
                  hintText: 'Patient Name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                 controller: controllerGName,
                decoration: const InputDecoration(
                  hintText: 'Guardian Name',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                controller: controllerGender,
                decoration: const InputDecoration(
                  hintText: 'Gender',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                controller: controllerAge,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Age',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                controller: controllerLang,
                decoration: const InputDecoration(
                  hintText: 'Regional Language',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                controller: controllerAddr,
                decoration: const InputDecoration(
                  hintText: 'Address',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
               TextField(
                controller: controllerPhone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Icon(
                    Icons.person_outline_sharp,
                    size: 22,
                    color: Color(0xfff97d7d),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                child:
                  ElevatedButton(
                    onPressed: () {
                      //user object
                      final user= User(
                          PName: controllerPName.text,
                          GName: controllerGName.text,
                          Gender: controllerGender.text,
                          Age: controllerAge.text,
                          Lang: controllerLang.text,
                          Addr: controllerAddr.text,
                          Phone: controllerPhone.text,
                      );
                      //write userdata into firebase server
                      createUser(user);

                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MedicalProfile()),
                      );
                    },
                    child: const Text(
                      'Create Profile',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 30,shadowColor:Colors.redAccent,primary:Colors.redAccent[200]
                    ),
                  ),
              ),
              const SizedBox(
                height: 14,
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future createUser(User user) async{
    final docUser = FirebaseFirestore.instance.collection('Users').doc();
    user.id= docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
//model object class
class User {
  String id;
  final String PName;
  final String GName;
  final String Gender;
  final String Age;
  final String Lang;
  final String Addr;
  final String Phone;

  User ({
    this.id='',
    required this.PName,
    required this.GName,
    required this.Gender,
    required this.Age,
    required this.Lang,
    required this.Addr,
    required this.Phone,
});

  Map<String, dynamic>toJson() => {
    'id': id,
    'PName': PName,
     'GName': GName,
     'Gender': Gender,
     'Age': Age,
     'Lang': Lang,
     'Addr': Addr,
     'Phone': Phone,
   };

}

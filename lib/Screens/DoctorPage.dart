//import 'dart:html';
import 'dart:ui';

import 'package:down_syndrome/Screens/DoctorDetailsPage.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    child: Text(
                      "Popular Doctors",
                      style: TextStyle(
                        color:Colors.indigoAccent,
                        fontSize: 20,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30, top: 1),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Show all",
                        style: TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 15,
                          fontFamily: "Roboto",
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: ListView(
                  children: [
                    Doctors("Assets/Images/maleDoctor4.PNG","Dr. Narayan Bose","Cardiologist"),
                    Doctors("Assets/Images/femaleDoctor4.PNG","Dr. Poulomi Sarkar","Paediatrician"),
                    Doctors("Assets/Images/maleDoctor2.png","Dr. Riddhiman Sen","Neurologist"),
                    Doctors("Assets/Images/femaleDoctor2.jpg","Dr. Asmita Dey","General Medicine"),
                    Doctors("Assets/Images/femaleDoctor3.jpg","Dr. Sayanti Roy","Paediatrician"),
                    Doctors("Assets/Images/maleDoctor2.png","Dr. Chiranjit Kumar","Paediatrician"),
                    Doctors("Assets/Images/femaleDoctor2.jpg","Dr. Anusha Ganesha","General Medicine"),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Doctors(String image, String name, String Speciality) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorDetailsPage()));
      },
      child: Container(
        height: 90,
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 100,
              width: 100,
              child: Image.asset(image),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top:10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize: 17,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                        Speciality,
                      style: TextStyle(
                        color: Colors.indigoAccent,
                        fontSize:13,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w300,
                      )
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

//import 'dart:html';
import 'dart:ui';

import 'package:down_syndrome/Screens/PaediatricsPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.only(
            topRight:Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 30),
              child: Text(
                'Popular Specialties',
                style: TextStyle(
                  color: Colors.indigoAccent,
                  fontSize: 20,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.only(top: 20, left: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Categories('Assets/Images/paedo.jfif', 'Paediatrics'),
                  Categories('Assets/Images/heart.png', 'Cardiology'),
                  Categories('Assets/Images/neurology.PNG', 'Neurology'),
                  Categories('Assets/Images/ent.png', 'ENT'),
                  Categories('Assets/Images/psycho.PNG', 'Psychology'),
                  Categories('Assets/Images/endocrine.png', 'Endocrinology'),
                ],
              ),
            )


          ],
      ),

    ),
    );
  }
  Widget Categories(String image, String name){
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Paediatrics()));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        width: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: const Offset(8.0, 8.0,),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(image),
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(15),
            ),
            Container(
              padding:EdgeInsets.all(7),
              margin:EdgeInsets.only(top: 10),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize:10,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w500,
                ),
              )

            )
          ],
        )
      ),
    );
  }
}

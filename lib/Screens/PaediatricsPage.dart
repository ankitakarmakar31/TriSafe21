import 'package:down_syndrome/Screens/Ped_Doctor_Details.dart';
import 'package:flutter/material.dart';

class Paediatrics extends StatefulWidget {
  const Paediatrics({Key? key}) : super(key: key);

  @override
  State<Paediatrics> createState() => _PaediatricsState();
}

class _PaediatricsState extends State<Paediatrics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        elevation: 8.8,
        title: Text("Paediatrics"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
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
                      "Paediatricians",
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
                    PedDoctors("Assets/Images/femaleDoctor3.jpg","Dr. Poulomi Sarkar","Paediatrician"),
                    PedDoctors("Assets/Images/femaleDoctor3.jpg","Dr. Sayanti Roy","Paediatrician"),
                    PedDoctors("Assets/Images/maleDoctor2.png","Dr. Chiranjit Kumar","Paediatrician"),
                  ],
                ),

              ),
            ),
          ],
        ),

      ),
    );
  }

  Widget PedDoctors(String image, String name, String Speciality) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Ped_Doctor_Details()));
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

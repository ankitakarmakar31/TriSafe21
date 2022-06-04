import 'package:flutter/material.dart';

class Ped_Doctor_Details extends StatefulWidget {
  const Ped_Doctor_Details({Key? key}) : super(key: key);

  @override
  State<Ped_Doctor_Details> createState() => _Ped_Doctor_DetailsState();
}

class _Ped_Doctor_DetailsState extends State<Ped_Doctor_Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Text("Pediatrics"),
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

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft:Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )
              ),
              child: Container(
                margin: EdgeInsets.only(left: 30, bottom: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Image.asset('Assets/Images/femaleDoctor4.PNG'),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Dr. Poulomi Sarkar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "Paediatrician",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Text(
                              "NewLife Hospital",
                              style: TextStyle(
                                  color: Colors.yellowAccent,
                                  fontSize: 17,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                  "March 2022",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontSize: 25,
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20,top: 20,right: 20),
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Dates("Mon","21",false),
                  Dates("Tue","22",false),
                  Dates("Wed","23",false),
                  Dates("Thu","24",false),
                  Dates("Fri","25",true),
                  Dates("Sat","26",false),
                  Dates("Sun","27",false),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Text(
                  "Select Time",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Roboto",
                    fontSize: 25,
                  )
              ),
            ),
            Container(
                width: 400,
                height: 200,
                margin: EdgeInsets.only(right: 20),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 3,
                  children: [
                    DoctorTimings("8.30 AM",false),
                    DoctorTimings("9.30 AM",false),
                    DoctorTimings("10.30 AM",false),
                    DoctorTimings("12.30 PM",false),
                    DoctorTimings("1.30 PM",true),
                    DoctorTimings("3.00 PM",false),
                  ],
                )
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              alignment: Alignment.center,
              height:50,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 20,left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Book An Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],

        ),
      ),

    );
  }

  DoctorTimings(String Time, bool isSelected) {
    return isSelected ? Container(
      margin: EdgeInsets.only(left: 20, top: 10),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Icon(
              Icons.access_time,
              color: Colors.white,
              size: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Text(
              Time,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: "Roboto",
              ),
            ),
          ),
        ],
      ),
    ) : Container(
      margin: EdgeInsets.only(left: 20, top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Icon(
              Icons.access_time,
              color: Colors.black,
              size: 18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 2),
            child: Text(
              Time,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: "Roboto",
              ),
            ),
          ),
        ],
      ),

    );
  }


  Dates(String Day, String Date, bool isSelected) {
    return isSelected ? Container(
      width: 70,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              Day,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(7),
            child: Text(
              Date,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ) : Container(
      width: 70,
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              Day,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(7),
            child: Text(
              Date,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

        ],
      ),

    );
  }

}

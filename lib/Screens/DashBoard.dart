
import 'package:down_syndrome/Screens/AmbulancePage.dart';
import 'package:down_syndrome/Screens/DoctorPage.dart';
import 'package:down_syndrome/Screens/Home/HomePage.dart';
import 'package:down_syndrome/Screens/HospitalPage.dart';
import 'package:down_syndrome/Screens/NursingPage.dart';

import 'package:flutter/material.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  @override
  Widget build(BuildContext context) => (
      DefaultTabController(
        length: 5,
          child: Scaffold(
            backgroundColor: Colors.redAccent[200],
            appBar: AppBar(
              elevation: 8.8,
              title: const Text("Welcome to the App"),
              centerTitle: true,
              backgroundColor: Colors.redAccent[200],
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                )
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                indicatorWeight: 5,
                tabs: [
                  Tab(icon: Icon(Icons.home), text: 'Home',),
                  Tab(icon: Icon(Icons.add_box), text: 'Doctor',),
                  Tab(icon: Icon(Icons.apartment_sharp), text: 'Hospital',),
                  Tab(icon: Icon(Icons.add_business_rounded),text: 'Nursing Service',),
                  Tab(icon: Icon(Icons.airport_shuttle_outlined),text: 'Ambulance Service',),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                HomePage(),
                DoctorPage(),
                HospitalPage(),
                NursingPage(),
                AmbulancePage(),
              ]
            ),


          )

    )
  );
  }
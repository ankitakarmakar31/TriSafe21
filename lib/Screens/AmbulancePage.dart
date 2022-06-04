import 'dart:ui';

import 'package:flutter/material.dart';

class AmbulancePage extends StatefulWidget {
  const AmbulancePage({Key? key}) : super(key: key);

  @override
  State<AmbulancePage> createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {

  final items= ["Basic Ambulance", "Advanced Ambulance", "Patient Transport", "Neonatal Ambulance", "Air Ambulance","Mortuary Van"];
  String? value;

  final items1= ["Peerless Hospital", "RN Tagore", "Desun Hospital", "Ruby Hospital", "Fortis Hospital","Amri Hospital", "Duncan Gleneagles"];
  String? value1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      body: SingleChildScrollView(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.all(20),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: const Text(
                    'Search for an Ambulance',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.indigoAccent),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Name',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.indigoAccent),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(
                            width: 5, style: BorderStyle.solid,
                          )
                      ),
                      hintText: 'Name ',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: Icon(
                        Icons.account_circle_rounded ,
                        size: 18,
                        color: Color(0xfff97d7d),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter your mobile number',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.indigoAccent),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(
                            width: 5, style: BorderStyle.solid,
                          )
                      ),
                      hintText: 'Phone Number',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: Icon(
                        Icons.ad_units_outlined,
                        size: 18,
                        color: Color(0xfff97d7d),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Ambulance Type',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.indigoAccent),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value,
                      isExpanded: true,
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down, color: Colors.redAccent[100],
                      ),
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Click here to see the description of each type of Ambulance',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: Colors.red),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Select Current Location ',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.indigoAccent),
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(
                            width: 5, style: BorderStyle.solid,
                          )
                      ),
                      hintText: 'Enter a location',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      suffixIcon: Icon(
                        Icons.add_location_alt_sharp,
                        size: 18,
                        color: Color(0xfff97d7d),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Select Drop Location ',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.indigoAccent),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 400,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: value1,
                      isExpanded: true,
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down, color: Colors.redAccent[100],
                      ),
                      items: items1.map(buildMenuItem).toList(),
                      onChanged: (value) => setState(() => this.value1 = value),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: MaterialButton(
                    color: const Color(0xfff97d7d),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      'Request for Ambulance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              color: Colors.black87,
              fontFamily:"Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ) ,
      );

}

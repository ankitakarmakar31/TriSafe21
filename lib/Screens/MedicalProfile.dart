//import 'dart:html';

import 'package:down_syndrome/Screens/one_to_threePage.dart';
import 'package:down_syndrome/Screens/zero_to_onePage.dart';
import 'package:flutter/material.dart';

class MedicalProfile extends StatefulWidget {
  const MedicalProfile({Key? key}) : super(key: key);

  @override
  State<MedicalProfile> createState() => _MedicalProfileState();
}

class _MedicalProfileState extends State<MedicalProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Profile"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: buildBasicListView(),
    );
  }

  Widget buildBasicListView() =>
      ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical:0.0, horizontal: 20.0),
        children: [
          ListTile(
            title: Text('0-1year'),
            subtitle: Text("Please click here if your child's age is 0-1 yr"),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => zero_to_onePage()),
                );
              },
            ),
          ),
          ListTile(
            title: Text('1-3years'),
            subtitle: Text("Please click here if your child's age is 1-3 yrs"),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => one_to_threePage()),
                );
              },
            ),
          ),
          ListTile(
            title: Text('3-5years'),
            subtitle: Text("Please click here if your child's age is 3-5 yrs"),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => zero_to_onePage()),
                );
              },
            ),
          ),
          ListTile(
            title: Text('5-7years'),
            subtitle: Text("Please click here if your child's age is 5-7 yrs"),
            leading: Icon(Icons.arrow_forward_ios_rounded),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => zero_to_onePage()),
                );
              },
            ),
          ),
        ],
      );


}

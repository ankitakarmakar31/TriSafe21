import 'package:flutter/material.dart';
import 'package:down_syndrome/Screens/UserProfile.dart';

class UserDetailsDoctor extends StatefulWidget {
  User user;
  UserDetailsDoctor({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailsDoctor> createState() => _UserDetailsDoctorState();
}

class _UserDetailsDoctorState extends State<UserDetailsDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent.shade100,
          title: Text('User Details')),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              maxRadius: 60,
              backgroundImage: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/3209/3209993.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Name: ' + widget.user.PName.toUpperCase()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('AGE: ' + widget.user.Age + ' Yrs'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.user.Gender.toUpperCase()),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Phone: ' + widget.user.Phone),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Does anyone in family have down syndrome: ' +
                widget.user.dsFamilyStatus),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Is your child affected with down syndrome: ' +
                widget.user.dsStatus),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Down Syndrome Type : ' + widget.user.dsType),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Health issue: ' + widget.user.extraHealthIssue),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Health issue details: ' + widget.user.extraHealthIssueSub),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Is the issue critical:${widget.user.isCritical ? "Yes" : "No"}'),
          ),
        ],
      )),
    );
  }
}

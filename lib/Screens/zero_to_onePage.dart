
//import 'dart:html';

import 'package:flutter/material.dart';
class zero_to_onePage extends StatefulWidget {

  @override
  State<zero_to_onePage> createState() => _zero_to_onePageState();
}

class _zero_to_onePageState extends State<zero_to_onePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Medical Profile"),
        centerTitle: true,
        backgroundColor: Colors.redAccent[200],
      ),
      body: Center(
        child: Text('hi'),
      ),
    );
  }
}

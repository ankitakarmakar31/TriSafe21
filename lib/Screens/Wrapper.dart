import 'package:down_syndrome/Screens/Authentication/Authenticate.dart';
import 'package:down_syndrome/Screens/DashBoard.dart';
import 'package:down_syndrome/Screens/Home/HomePage.dart';
import 'package:down_syndrome/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'LoginUiPage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return LoginUiPage();
    }
  }
}
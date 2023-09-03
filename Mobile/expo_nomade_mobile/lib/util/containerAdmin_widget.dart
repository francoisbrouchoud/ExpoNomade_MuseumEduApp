import 'package:expo_nomade_mobile/util/container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin/login_page.dart';

class ContainerAdminWidget extends StatelessWidget {
  const ContainerAdminWidget(
      {super.key,
      required this.title,
      required this.body,
      required this.refresh});

  final String title;
  final Widget body;
  final Function() refresh;

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return LoginPage(
        refresh: refresh,
      );
    }
    return ContainerWidget(title: title, isAdmin: true, body: body);
  }
}

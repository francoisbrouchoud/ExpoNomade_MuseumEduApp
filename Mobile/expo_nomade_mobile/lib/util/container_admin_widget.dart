import 'package:expo_nomade_mobile/util/container_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../admin/login_page.dart';

class ContainerAdminWidget extends StatelessWidget {
  const ContainerAdminWidget(
      {super.key,
      required this.title,
      required this.body,
      this.fixedContainerHeight = false});

  final String title;
  final Widget body;
  final bool fixedContainerHeight;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataNotifier>(context, listen: true);
    if (!dataProvider.isLogin) {
      if (FirebaseAuth.instance.currentUser == null) {
        return const LoginPage();
      }
    }
    dataProvider.setIsLogin(true);
    return ContainerWidget(
      title: title,
      isAdmin: true,
      body: body,
      fixedContainerHeight: fixedContainerHeight,
    );
  }
}

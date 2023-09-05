import 'package:expo_nomade_mobile/util/container_widget.dart';
import 'package:expo_nomade_mobile/util/globals.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../admin/login_page.dart';

class ContainerAdminWidget extends StatefulWidget {
  const ContainerAdminWidget(
      {Key? key,
      required this.title,
      required this.body,
      this.fixedContainerHeight = false})
      : super(key: key); // Correction du nom du paramètre
  final String title;
  final Widget body;
  final bool fixedContainerHeight;

  @override
  State<ContainerAdminWidget> createState() => _ContainerAdminWidgetState();
}

class _ContainerAdminWidgetState extends State<ContainerAdminWidget> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<LoginNotifier>(context, listen: true);
    if (!dataProvider.isLogin) {
      if (FirebaseAuth.instance.currentUser == null) {
        return const LoginPage();
      }
    }
    return ContainerWidget(
      title: widget.title,
      isAdmin: true,
      body: widget.body,
      fixedContainerHeight: widget.fixedContainerHeight,
    );
  }
}

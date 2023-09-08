import 'package:expo_nomade_mobile/widgets/container_widget.dart';
import '../helper/notifer_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../admin/login_page.dart';

/// Class ContainerAdminWidget is a container designed in the style of the application for the administration part.
class ContainerAdminWidget extends StatefulWidget {
  /// Creates a new ContainerAdminWidget
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

/// State class for the ContainerAdminWidget.
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

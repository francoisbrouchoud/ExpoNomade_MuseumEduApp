import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/util/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../bo/exposition.dart';
import 'expo_axis_list.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.exposition})
      : super(key: key); // Correction du nom du paramètre

  final Exposition exposition;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final translations = AppLocalization.of(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: mailController,
                  decoration: InputDecoration(
                      labelText: translations.getTranslation("email")),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: translations.getTranslation("password")),
                ),
                ButtonWidget(
                  action: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: mailController
                                    .text, //"exponomade.grp2@gmail.com",
                                password: passwordController.text); //"123456");
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ExpoAxisListWidget(
                                  exposition: widget.exposition)),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      } on Exception catch (e) {
                        print("nulll!!!!!!!!!!!!!!");
                      }
                    } else {
                      print('Not valide!!!');
                    }
                  },
                  text: translations.getTranslation("login"),
                  type: ButtonWidgetType.standard,
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:expo_nomade_mobile/app_localization.dart';
import 'package:expo_nomade_mobile/firebase_service.dart';
import 'package:expo_nomade_mobile/util/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../util/container_widget.dart';
import '../util/globals.dart';
import '../util/validation_helper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key}); // Correction du nom du paramètre

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController mailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final loginProvider = Provider.of<LoginNotifier>(context, listen: true);
    final dataProvider = Provider.of<ExpositionNotifier>(context, listen: true);

    final translations = AppLocalization.of(context);
    return ContainerWidget(
        title: translations.getTranslation("login"),
        isAdmin: true,
        body: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.getTranslation("please_not_null");
                        }
                        if (!ValidationHelper.isValidEmail(value)) {
                          return translations
                              .getTranslation("please_email_valid");
                        }
                        return null;
                      },
                      controller: mailController,
                      decoration: InputDecoration(
                          labelText: translations.getTranslation("email")),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.getTranslation("please_not_null");
                        }
                        return null;
                      },
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: translations.getTranslation("password")),
                    )),
                const SizedBox(height: 30),
                ButtonWidget(
                  action: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: mailController.text,
                            password: passwordController.text);
                        var expos = await FirebaseService.getAllExpoNames();
                        dataProvider.setExpositions(expos!);
                        loginProvider.setIsLogin(true);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found' ||
                            e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(translations.getTranslation(e.code))));
                        }
                      }
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

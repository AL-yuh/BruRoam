import 'package:bruroam/components/my_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:bruroam/provider/locale_provider.dart';


class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final TextEditingController emailController = TextEditingController();

  Future<void> _forgotPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
    } on FirebaseAuthException catch (_) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgotPasswordPage),
        backgroundColor: const Color(0xFFF2DC56),
        centerTitle: true,

        actions: [
          DropdownButton<Locale>(
            items: AppLocalizations.supportedLocales.map(
              (locale) => DropdownMenuItem<Locale> (
                value: locale,
                child: Text(locale.languageCode),
              ),
            ).toList(),
            onChanged: (Locale? locale) {
              if(locale != null) {
                provider.setLocale(locale);
              }
            }
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF2DC56), // Yellow background color
      body: Column(
        children: [
          const SizedBox(height: 20,),


          //white card area
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyTextFormField(
                    labelText: AppLocalizations.of(context)!.email, 
                    controller: emailController
                    ),

                    const SizedBox(height: 40),

                    Center(
                      child: SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: _forgotPassword,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF2DC56),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                         ),
                         child: Text(AppLocalizations.of(context)!.sendEmail),
                        )
                      )
                    )
                ]
              )
            )
          )
        ]
      )
    );
  }
}

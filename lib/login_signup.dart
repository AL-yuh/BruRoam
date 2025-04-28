

import 'package:flutter/material.dart';
import 'package:bruroam/components/my_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bruroam/provider/locale_provider.dart';
import 'package:provider/provider.dart';

class LoginSignup extends StatelessWidget {
  const LoginSignup({super.key});

   @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('BruRoam'),
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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              
              // Logo
              SizedBox(
                height: 100,
                width: 100,
                child: CustomPaint(
                  // painter: LogoPainter(),
                ),
              ),
              const Spacer(),
              // Login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 70),
                    elevation: 0,
                    
                  ),
                  child: Text(AppLocalizations.of(context)!.logIn),
                ),
                
              ),
              // Sign up button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 70),
                    elevation: 0,
                  ),
                 child: Text(AppLocalizations.of(context)!.signUp),

                ),
              ),
              const SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}


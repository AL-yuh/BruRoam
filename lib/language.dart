// first screen

import 'package:bruroam/provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:bruroam/components/my_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';


class Language extends StatelessWidget {
  const Language({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                
              ),
              const SizedBox(height: 190),
              // White container for language options
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)!.selectLanguage),
            
                    const SizedBox(height: 25),
                    _buildLanguageOption('English', context),
                    const SizedBox(height: 15),
                    _buildLanguageOption('中国人', context),
                    const SizedBox(height: 15),
                    _buildLanguageOption('Bahasa Melayu', context),
                  ],                  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language, BuildContext context) {
    return GestureDetector(
      onTap: () {
       final provider = Provider.of<LocaleProvider>(context, listen: false);

       // Match language to locale
       Locale newLocale;
       switch (language) {
        case 'English':
          newLocale = Locale('en');
          break;
        case '中国人':
          newLocale = Locale('zh');
          break;
        case 'Bahasa Melayu':
          newLocale = Locale('ms');
          break;
        default:
          newLocale = Locale('en');
       }

       provider.setLocale(newLocale);

       Navigator.pushNamed(context, '/login_signup');
      },
      child: Text(language),

    );
  }
}

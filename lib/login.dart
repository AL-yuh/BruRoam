import 'package:bruroam/provider/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bruroam/components/my_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _typedEmail = '';
  String _typedPassword = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async{
    _typedEmail = _emailController.text;
    _typedPassword = _passwordController.text;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _typedEmail, 
      password: _typedPassword
      );
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/homepage');
      }
    } on FirebaseException catch (_) {
      SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(AppLocalizations.of(context)!.invalidEmailOrPassword),
        duration: const Duration(seconds: 5),
        );
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.loginPage),
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
          const SizedBox(height: 20),

          Expanded(
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

                  // Email field
                  Text(AppLocalizations.of(context)!.email),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
                    // validator: (value) {
                    //   if (value == null || value.isEmpty) {
                    //     return 'Please enter an email';
                    //   }
                    // return null;
                    // },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  
                  // Password field
                  Text(AppLocalizations.of(context)!.password),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _showPassword,
                              onChanged: (value) {
                                setState(() {
                                  _showPassword = value!;
                                });
                              },
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                              activeColor: const Color(0xFFF2DC56),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(AppLocalizations.of(context)!.showPassword),
                        ],
                      ),
                    ),
                    obscureText: !_showPassword,
                  ),
                  const SizedBox(height: 10),
                  
                  // Forgot password link
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/forgotPassword');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFF2DC56),
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: 
                      Text(AppLocalizations.of(context)!.forgotPassword),
                      
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Login button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF2DC56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(AppLocalizations.of(context)!.logIn),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Sign up section
                  Center(
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.dontHaveAnAccount),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFF2DC56),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(AppLocalizations.of(context)!.signUp),
                        ),
                      ],
                    ),
                  ),
                  
                  const Spacer(),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


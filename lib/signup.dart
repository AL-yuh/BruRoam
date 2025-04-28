import 'package:bruroam/provider/locale_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bruroam/components/my_text_form_field.dart';
import 'package:provider/provider.dart';


class Signup extends StatefulWidget {
  const Signup ({super.key});

  @override
  State<Signup> createState()=> _SignupState();
}

class _SignupState extends State<Signup> {
  bool _showPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  String _typedEmail = '';
  String _typedPassword = '';
  String _typedUsername = '';

  Future<void> _signup () async{
    _typedEmail = _emailController.text;
    _typedPassword = _passwordController.text;
    _typedUsername = _usernameController.text;

    try{
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _typedEmail, 
        password: _typedPassword,
        );
        User? user = credential.user;
        if(user!= null){
          DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
          userDoc.set (
            {
              'username': _typedUsername,
            }
          );
        }

        if(mounted) {
        Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }

    } on FirebaseAuthException catch (_) {
      SnackBar snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(AppLocalizations.of(context)!.unableToRegister),
        duration: const Duration(seconds: 3),
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
        title: 
        Text(AppLocalizations.of(context)!.signUpPage),
        backgroundColor: Color(0xFFF2DC56),
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
      backgroundColor: const Color(0xFFF2DC56),
      body: Column(
        children: [
          const SizedBox(height: 20,),

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

                  //username field
                  Text(AppLocalizations.of(context)!.username),
                  TextField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //email field
                  Text(AppLocalizations.of(context)!.email),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Password field
                  Text(AppLocalizations.of(context)!.password),
                  TextField(
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

                  //phone number field
                  Text(AppLocalizations.of(context)!.phoneNumber),
                  TextField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //log in section
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _signup,
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFF2DC56),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(AppLocalizations.of(context)!.signUp),
                        ),
                        Text(AppLocalizations.of(context)!.alreadyHaveAnAccount),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFFF2DC56),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(AppLocalizations.of(context)!.logIn),
                        ),
                      ],
                    ),
                  ),
                
                ],
              ),
            )  
          )
        ],
      ),
    );
  }
}

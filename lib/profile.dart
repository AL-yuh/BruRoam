import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bruroam/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill with sample data
    _nameController.text = '';
    _nationalityController.text = '';
    _aboutController.text = '';
  }
  
  DateTime? _selectedDate;
   final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _nameController.dispose();
    _nationalityController.dispose();
    _aboutController.dispose();
    _genderController.dispose();

    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

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
      body: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFFF2DC56).withOpacity(0.3),
            child: const Icon(
              Icons.person,
              size: 60,
              color: Color.fromARGB(255, 229, 227, 213),
            ),
          ),
                      

          const SizedBox(height: 15),

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
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      // Color(0xFFF2DC56),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
                    
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your  name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      // Color(0xFFF2DC56),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    
                      hintText: _selectedDate == null
                          ? 'Select a date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    validator: (value) {
                      if (_selectedDate == null) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _nationalityController,
                decoration: const InputDecoration(
                      labelText: 'Nationality',
                      // Color(0xFFF2DC56),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a nationality';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                    controller: _genderController,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      // Color(0xFFF2DC56),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
                    
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: _aboutController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                      labelText: 'About Me',
                      // Color(0xFFF2DC56),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFF2DC56), width: 2),
                      ),
                    ),
              ),


              const SizedBox(height: 10),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2DC56),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newEvent = ProfilePage(
                      );

                      Navigator.pop(context, newEvent); // Return the event
                    }
                  },
                  child: const Text('Done'),
                ),
              ),
            ],
          ),
        ),
      ),
        ]
      )
    );
  }
}

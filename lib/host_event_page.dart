import 'package:flutter/material.dart';
import 'group_event.dart';
import 'package:intl/intl.dart';

class HostEventPage extends StatefulWidget {
  const HostEventPage({super.key});

  @override
  State<HostEventPage> createState() => _HostEventPageState();
}

class _HostEventPageState extends State<HostEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _maxPaxController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _chatRoomLinkController = TextEditingController();


  DateTime? _selectedDate;
   final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _locationController.dispose();
    _durationController.dispose();
    _maxPaxController.dispose();
    _descriptionController.dispose();
    _chatRoomLinkController.dispose();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Host'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _pickDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date',
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _maxPaxController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Maximum Pax'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter maximum pax';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
               const SizedBox(height: 16),
              TextFormField(
                controller: _chatRoomLinkController,
                decoration: const InputDecoration(
                  labelText: 'Chat Room Link',
                  hintText: 'WhatsApp or Telegram is recommended',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a chat room link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newEvent = GroupEvent(
                        location: _locationController.text,
                        date: _selectedDate!,
                        duration: _durationController.text,
                        description: _descriptionController.text,
                        attendees: 1, // Default attendee is the host
                        maxPax: int.parse(_maxPaxController.text),
                        chatRoomLink: _chatRoomLinkController.text,
                      );

                      Navigator.pop(context, newEvent); // Return the event
                    }
                  },
                  child: const Text('Create Event'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
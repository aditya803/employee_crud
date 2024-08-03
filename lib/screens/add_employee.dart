import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final List<ContactMethod> _contactMethods = [];

  void _addContactMethod() {
    _contactMethods.add(ContactMethod(contactMethod: 'EMAIL', value: ''));
    setState(() {});
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        id: '',
        name: _nameController.text,
        address: _addressController.text,
        city: _cityController.text,
        country: _countryController.text,
        zipCode: _zipCodeController.text,
        contactMethods: _contactMethods,
      );
      ApiService().createEmployee(newEmployee).then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _countryController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a country';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _zipCodeController,
                decoration: InputDecoration(labelText: 'Zip Code'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a zip code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Contact Methods:'),
              ..._contactMethods.map((method) {
                return Row(
                  children: [
                    DropdownButton<String>(
                      value: method.contactMethod,
                      items: ['EMAIL', 'PHONE'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          method.contactMethod = newValue!;
                        });
                      },
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: method.value,
                        decoration: InputDecoration(labelText: 'Value'),
                        onChanged: (newValue) {
                          method.value = newValue;
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
              TextButton(
                onPressed: _addContactMethod,
                child: Text('Add Contact Method'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

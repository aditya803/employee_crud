import 'package:employee_crud/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class AddEmployeeScreen extends StatefulWidget {
  final VoidCallback onEmployeeAdded;

  AddEmployeeScreen({required this.onEmployeeAdded});

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
  List<Contact> _contactMethods = [];

  void _addContactMethod() {
    setState(() {
      _contactMethods.add(Contact(contactMethod: 'Mobile', number: ''));
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        name: _nameController.text,
        address: _addressController.text,
        city: _cityController.text,
        country: _countryController.text,
        zipCode: int.parse(_zipCodeController.text),
        contact: _contactMethods.first,
      );
      ApiService().createEmployee(newEmployee).then((_) {
        widget.onEmployeeAdded();
        Navigator.pop(context);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to add employee: $error'),
        ));
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
              CustomTextField(
                controller: _nameController,
                labelText: 'Name',
                keyboardType: TextInputType.text,
                validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              }),
              CustomTextField(
                  controller: _addressController,
                  labelText: 'Address',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  }),
              CustomTextField(
                  controller: _cityController,
                  labelText: 'City',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a city';
                    }
                    return null;
                  }),
              CustomTextField(
                  controller: _countryController,
                  labelText: 'Country',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a country';
                    }
                    return null;
                  }),
              CustomTextField(
                  controller: _zipCodeController,
                  labelText: 'Zip Code',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a zip code';
                    }
                    return null;
                  }),

              SizedBox(height: 16),
              Text('Contact Methods:',style: GoogleFonts.poppins(fontSize: 15),),
              ..._contactMethods.map((method) {
                return Row(
                  children: [
                    DropdownButton<String>(
                      value: method.contactMethod,
                      items: ['Mobile', 'Email'].map((String value) {
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
                      child: CustomTextField(
                        labelText: method.contactMethod, keyboardType: TextInputType.text, onChanged: (newValue) {
                        setState(() {
                          method.number = newValue!;
                        });
                      },),
                    ),
                  ],
                );
              }).toList(),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _addContactMethod,
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  ),
                  child: Text('Add Contact Method'),
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed:_submitForm),
    );
  }
}

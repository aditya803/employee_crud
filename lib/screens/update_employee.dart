import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';
import '../widgets/custom_textfield.dart';

class UpdateEmployeeScreen extends StatefulWidget {

  final Employee employee;

  UpdateEmployeeScreen({required this.employee});

  @override
  _UpdateEmployeeScreenState createState() => _UpdateEmployeeScreenState();
}

class _UpdateEmployeeScreenState extends State<UpdateEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  late TextEditingController _zipCodeController;
  late TextEditingController _contactMethodController;
  late TextEditingController _contactValueController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.name);
    _addressController = TextEditingController(text: widget.employee.address);
    _cityController = TextEditingController(text: widget.employee.city);
    _countryController = TextEditingController(text: widget.employee.country);
    _zipCodeController = TextEditingController(text: widget.employee.zipCode.toString());
    _contactMethodController = TextEditingController(text: widget.employee.contact.contactMethod);
    _contactValueController = TextEditingController(text: widget.employee.contact.number);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedEmployee = Employee(
        id: widget.employee.id,
        name: _nameController.text,
        address: _addressController.text,
        city: _cityController.text,
        country: _countryController.text,
        zipCode: int.parse(_zipCodeController.text),
        contact: Contact(
          contactMethod: _contactMethodController.text,
          number: _contactValueController.text,
        ),
      );

      ApiService().updateEmployee(updatedEmployee).then((_) {
        Navigator.pop(context, updatedEmployee);
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to update employee: $error'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Employee'),
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
                },
              ),
              CustomTextField(
                controller: _addressController,
                labelText: 'Address',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an address';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _cityController,
                labelText: 'City',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a city';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _countryController,
                labelText: 'Country',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a country';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _zipCodeController,
                labelText: 'Zip Code',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a zip code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _contactMethodController.text,
                items: ['Mobile', 'Email'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _contactMethodController.text = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Contact Method',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a contact method';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _contactValueController,
                labelText: 'Contact Value',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if(_contactMethodController?.value.toString()=="Email"){
                    if (!value!.contains('@')||value!.isEmpty) {
                      return 'Please enter a valid email value';
                    }
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Update Employee'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

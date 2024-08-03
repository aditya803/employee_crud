import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final String id;

  EmployeeDetailsScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details'),
      ),
      body: FutureBuilder<Employee>(
        future: ApiService().fetchEmployee(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Employee not found'));
          } else {
            final employee = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${employee.name}'),
                  SizedBox(height: 8),
                  Text('Address: ${employee.address}, ${employee.city}, ${employee.country}, ${employee.zipCode}'),
                  SizedBox(height: 8),
                  Text('Contact Methods:'),
                  ...employee.contactMethods.map((method) => Text('${method.contactMethod}: ${method.value}')).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

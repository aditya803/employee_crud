import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onTap;

  EmployeeCard({required this.employee, required this.onTap});

  void deleteEmployee(BuildContext context){
    ApiService().deleteEmployee(employee.id!).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to add employee: $error'),
      ));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(employee.name),
        subtitle: Text(employee.id!),
        onTap: onTap,
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // handle delete
            deleteEmployee(context);
          },
        ),
      ),
    );
  }
}

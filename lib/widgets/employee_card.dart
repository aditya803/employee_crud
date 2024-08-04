import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onTap;
  final VoidCallback delete;

  EmployeeCard({required this.employee, required this.onTap, required this.delete});

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.account_circle,color: Colors.black,),
          ),
          title: Text(employee.name,style: TextStyle(fontWeight: FontWeight.bold),),
          subtitle: Text(employee.contact.number),
          onTap: onTap,
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // handle delete
              delete();
              deleteEmployee(context);
            },
          ),
        ),
      ),
    );
  }
}

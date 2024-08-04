import 'package:employee_crud/screens/update_employee.dart';
import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final String id;
  final VoidCallback onTap;



  EmployeeDetailsScreen({required this.id, required this.onTap});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late Future<Employee> _employeeFuture;

  @override
  void initState() {
    super.initState();
    _employeeFuture = ApiService().fetchEmployee(widget.id);
  }

  void _refreshEmployee() {
    setState(() {
      _employeeFuture = ApiService().fetchEmployee(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context){
            return IconButton(onPressed: (){
              widget.onTap();
              Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back));
          },
        ),
        title: Text('Employee Details'),
      ),
      body: FutureBuilder<Employee>(
        future: ApiService().fetchEmployee(widget.id),
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
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.account_circle, color: Colors.black, size: 50),
                    ),
                  ),
                  SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${employee.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(height: 8),
                      Text('Address: ${employee.address}, ${employee.city}, ${employee.country}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(height: 8,),
                      Text('ZipCode: ${employee.zipCode}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                      SizedBox(height: 8),
                      Text('${employee.contact.contactMethod}: ${employee.contact.number}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FutureBuilder<Employee>(
        future: ApiService().fetchEmployee(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final updatedEmployee = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateEmployeeScreen(employee: snapshot.data!),
                  ),
                );
                if (updatedEmployee != null) {_refreshEmployee();}
                },
              child: Icon(Icons.edit),
            );
          } else {
            return const Text("No employee data found"); // Placeholder when employee data is not yet available
          }
        },
      ),
    );
  }
}

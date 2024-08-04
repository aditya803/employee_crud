import 'package:employee_crud/widgets/employee_card.dart';
import 'package:flutter/material.dart';
import '../models/employee.dart';
import '../services/api_service.dart';
import 'add_employee.dart';
import 'employee_details.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> _employeeListFuture;

  @override
  void initState() {
    super.initState();
    _fetchEmployees();
  }

  void _fetchEmployees() {
    setState(() {
      _employeeListFuture = ApiService().fetchEmployees();
    });
  }

  void _refreshEmployees() {
    _fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Employee List'),
      ),
      body: FutureBuilder<List<Employee>>(
        future: _employeeListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No employees found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final employee = snapshot.data![index];
                return EmployeeCard(
                  employee: employee,
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => EmployeeDetailsScreen(
                              id: employee.id!, onTap: _refreshEmployees,
                          )));
                    }, delete: _refreshEmployees,);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeeScreen(
                onEmployeeAdded: _refreshEmployees,
              ),
            ),
          );
        },
      ),
    );
  }
}

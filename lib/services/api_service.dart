import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee.dart';

class ApiService {
  final String baseUrl = 'https://free-ap-south-1.cosmocloud.io/development/api';
  final String projectId = '66ae0806d0f7f3ef85a5e665';  // Replace with your actual projectId
  final String environmentId = '66ae0806d0f7f3ef85a5e666';  // Replace with your actual environmentId

  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/employees?offset=0&limit=10'),
        headers: {
          'Content-Type': 'application/json',
          'projectId': projectId,
          'environmentId': environmentId,
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> data = jsonResponse['data'];
        return data.map((dynamic item) => Employee.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load employees');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load employees');
    }
  }

  Future<Employee> fetchEmployee(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/employees/$id'),
        headers: {
          'Content-Type': 'application/json',
          'projectId': projectId,
          'environmentId': environmentId,
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        return Employee.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load employee');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load employee');
    }
  }

  Future<void> createEmployee(Employee employee) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/employees'),
        headers: {
          'Content-Type': 'application/json',
          'projectId': projectId,
          'environmentId': environmentId,
        },
        body: json.encode(employee.toJson()),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode != 201) {
        throw Exception('Failed to create employee');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to create employee');
    }
  }

  Future<void> deleteEmployee(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/employees/$id'),
        headers: {
          'Content-Type': 'application/json',
          'projectId': projectId,
          'environmentId': environmentId,
        },
        body: json.encode({})
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete employee');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to delete employee');
    }
  }
}

// lib/controllers/employee_controller.dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/employee.dart';

class EmployeeController {
  final SupabaseClient _supabaseClient;

  EmployeeController(this._supabaseClient);

   // Fetch all employees
  Future<List<Employee>> getEmployees() async {
    final response = await _supabaseClient.from('employees').select().execute();

   if (response.error != null) {
      throw Exception('Failed to load employees: ${response.error!.message}');
    }

     // Check if data is empty
    if (response.data == null || (response.data as List).isEmpty) {
      return [];
    }

   List<dynamic> data = response.data;
    return data.map((employeeData) => Employee.fromMap(employeeData)).toList();
  }

  // Add a new employee
  Future<void> createEmployee(Employee employee) async {
    final response = await _supabaseClient.from('employees').insert(employee.toMap()).execute();

    if (response.error != null) {
      throw response.error!;
    }
  }

  // Update an existing employee
  Future<void> updateEmployee(Employee employee) async {
    final response = await _supabaseClient
        .from('employees')
        .update(employee.toMap())
        .eq('id', employee.id)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }
  }
  
  // Delete an employee
  Future<void> deleteEmployee(int id) async {
    final response = await _supabaseClient.from('employees').delete().eq('id', id).execute();

    if (response.error != null) {
      throw response.error!;
    }
  }
}

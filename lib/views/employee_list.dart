// lib/views/employee_list.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/employee_controller.dart';
import '../models/employee.dart';
import 'employee_create.dart';
import 'employee_edit.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  late EmployeeController _employeeController;
  late Future<List<Employee>> _employeeListFuture;

  @override
  void initState() {
    super.initState();
    _employeeController = EmployeeController(Supabase.instance.client);
    _employeeListFuture = _employeeController.getEmployees();
  }

  // Method to refresh the list after an operation
  Future<void> _refreshEmployeeList() async {
    setState(() {
      _employeeListFuture = _employeeController.getEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee List')),
      body: FutureBuilder<List<Employee>>(
        future: _employeeListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final employees = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _refreshEmployeeList,  // Trigger refresh on pull-to-refresh
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text(employee.position),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await _employeeController.deleteEmployee(employee.id);
                      // Refresh the list after deletion
                      _refreshEmployeeList();
                    },
                  ),
                  onTap: () async {
                    // Navigate to the edit screen and update list after editing
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeEdit(employee: employee),
                      ),
                    );
                    if (updated != null && updated) {
                      _refreshEmployeeList();
                    }
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EmployeeCreate()),
          );
          if (created != null && created) {
            _refreshEmployeeList();  // Refresh after employee is created
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

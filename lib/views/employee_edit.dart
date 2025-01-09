// lib/views/employee_edit.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../controllers/employee_controller.dart';
import '../models/employee.dart';

class EmployeeEdit extends StatefulWidget {
  final Employee employee;

  const EmployeeEdit({super.key, required this.employee});

  @override
  _EmployeeEditState createState() => _EmployeeEditState();
}

class _EmployeeEditState extends State<EmployeeEdit> {
  final _nameController = TextEditingController();
  final _positionController = TextEditingController();
  final _salaryController = TextEditingController();
  late EmployeeController _employeeController;

  @override
  void initState() {
    super.initState();
    _employeeController = EmployeeController(Supabase.instance.client);
    _nameController.text = widget.employee.name;
    _positionController.text = widget.employee.position;
    _salaryController.text = widget.employee.salary.toString();
  }

  Future<void> _updateEmployee() async {
    final updatedEmployee = widget.employee.copyWith(
      name: _nameController.text,
      position: _positionController.text,
      salary: double.parse(_salaryController.text),
    );

    await _employeeController.updateEmployee(updatedEmployee);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Employee')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _positionController, decoration: const InputDecoration(labelText: 'Position')),
            TextField(
              controller: _salaryController,
              decoration: const InputDecoration(labelText: 'Salary'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateEmployee,
              child: const Text('Update Employee'),
            ),
          ],
        ),
      ),
    );
  }
}

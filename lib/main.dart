import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'views/employee_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
     url: 'https://cipbqtsftphjkpawsskn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNpcGJxdHNmdHBoamtwYXdzc2tuIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTczMzYzNjUxNiwiZXhwIjoyMDQ5MjEyNTE2fQ.5Jwj2oQH7CaHnY9MxfxuTIf4tYFTy6s-wLD0t4rzb7o',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee CRUD with MVC',
      home: EmployeeList(),
    );
  }
}

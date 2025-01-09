// lib/models/employee.dart
class Employee {
  final int id;
  final String name;
  final String position;
  final double salary;
  final DateTime createdAt;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
    required this.createdAt,
  });

  // Factory method to create an Employee from a map (from Supabase)
  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      id: map['id'],
      name: map['name'],
      position: map['position'],
      salary: map['salary'],
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  // Convert Employee to Map for inserting into Supabase
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'position': position,
      'salary': salary,
      'created_at': createdAt.toIso8601String(),
    };
  }

 // copyWith method to create a copy of the Employee with modified fields
  Employee copyWith({
    int? id,
    String? name,
    String? position,
    double? salary,
    DateTime? createdAt,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      salary: salary ?? this.salary,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
  

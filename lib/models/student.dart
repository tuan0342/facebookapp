class Student {
  final int id;
  final String name;
  final String address;
  final String className;
  final double gpa;

  const Student({
    required this.id,
    required this.name,
    required this.address,
    required this.className,
    required this.gpa,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'className': className,
      'gpa': gpa,
    };
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, address: $address, className: $className, gpa: $gpa}';
  }
}
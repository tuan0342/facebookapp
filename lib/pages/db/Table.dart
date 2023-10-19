import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/student.dart';

class TableStudents extends StatelessWidget {
  const TableStudents({super.key,
    required this.students,
    required this.onDeleteStudent,
    required this.onUpdateStudent});

  final Future<void> Function(Student) onDeleteStudent;
  final Future<void> Function(Student) onUpdateStudent;

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text("id")),
            DataColumn(label: Text("name")),
            DataColumn(label: Text("address")),
            DataColumn(label: Text("class")),
            DataColumn(label: Text("gpa")),
          ],
          rows: <DataRow>[
            ...students.map((e) => DataRow(
                cells: <DataCell>[
                  DataCell(Text("${e.id}")),
                  DataCell(Text("${e.name}")),
                  DataCell(Text("${e.address}")),
                  DataCell(Text("${e.className}")),
                  DataCell(Text("${e.gpa}")),
                ],
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text(
                          "Facebook app"
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onUpdateStudent(e);
                              },
                              child: const Text('Update'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              onDeleteStudent(e);
                            },
                            child: const Text('Delete'),
                          )
                        ],
                      )
                  );
                }
              )
            )
          ]),
    );
  }
}

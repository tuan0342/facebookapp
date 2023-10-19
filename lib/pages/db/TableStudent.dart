import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/pages/db/AddStudent.dart';
import 'package:facebook_app/pages/db/Table.dart';
import 'package:facebook_app/pages/db/UpdateStudent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/database.dart';
import '../../models/student.dart';
import '../../my_widgets/my_app_bar.dart';

class StudentsTable extends StatefulWidget {
  const StudentsTable({super.key});

  @override
  State<StudentsTable> createState() => _StudentsTableState();
}

class _StudentsTableState extends State<StudentsTable> {

  Future<List<Student>> getStudents() async {
    final List<Map<String, dynamic>> students = await database().query('students');
    return List.generate(students.length, (i) => Student(
        id: students[i]['id'],
        name: students[i]['name'],
        address: students[i]['address'],
        className: students[i]['className'],
        gpa: students[i]['gpa']));
  }

  Future<void> submit (Student student) async {
    // final newStudent = Student(id: int.parse(idPrimary.text),
    //     name: name.text, address: address.text,
    //     className: classes.text, gpa: double.parse(gpa.text));
    database().insert('students', student.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {});
  }

  void addStudent() {
    showModalBottomSheet(context: context, isScrollControlled: true,
        builder: (context) => AddStudent(onSubmit: submit));
  }

  Future<void> deleteStudent (Student student) async {
    database().delete('students', where: 'id = ?', whereArgs: [student.id]);
    setState(() {});
  }

  Future<void> onUpdateStudent (Student student) async {
    database().update('students', student.toMap(), where: 'id = ?',
        whereArgs: [student.id]);
    setState(() {});
  }

  Future<void> updateStudent(Student student) async{
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => UpdateStudent(
          oldStudent: student,
          onUpdateStudent: onUpdateStudent,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getStudents(),
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const MyAppBar(title: "Student Table"),
            body: SafeArea(
              child: TableStudents(
                students: snapshot.data!,
                onDeleteStudent: deleteStudent,
                onUpdateStudent: updateStudent,
              )
            ),
            bottomNavigationBar: ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton( child: const Text('Add Student'), onPressed: addStudent,)
              ],
            ),
          );
        } else {
          return Text("waiting");
        }
    });
  }
}


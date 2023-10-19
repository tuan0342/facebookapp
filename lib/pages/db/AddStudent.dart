import 'package:facebook_app/my_widgets/my_app_bar.dart';
import 'package:facebook_app/my_widgets/my_filled_button.dart';
import 'package:facebook_app/my_widgets/my_text_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/database.dart';
import '../../models/student.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key, required this.onSubmit});

  final void Function(Student) onSubmit;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController idPrimary = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController classes = TextEditingController();
  TextEditingController gpa = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Image.asset(
              "assets/images/logo.png",
              width: 40,
              height: 40,
            ),
          ),
          Expanded(
            flex: 8,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: idPrimary,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10))),
                          labelText: "Id"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your id';
                        }
                        // if (!EmailValidator.validate(value)) {
                        //   return "Email is invalid!";
                        // }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      controller: address,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "address"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      controller: classes,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "class"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your class';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: TextFormField(
                      controller: gpa,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "gpa"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gpa';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TextButton( child: const Text('Cancel'), onPressed: () {
            Navigator.pop(context);
          }),
          TextButton( child: const Text('Add Student'), onPressed: () {
            final newStudent = Student(id: int.parse(idPrimary.text),
                name: name.text, address: address.text,
                className: classes.text, gpa: double.parse(gpa.text));
            widget.onSubmit(newStudent);
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }
}
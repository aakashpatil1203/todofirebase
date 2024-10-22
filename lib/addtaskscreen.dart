// // add_task_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/providertask.dart';

class AddTaskScreen extends StatefulWidget {
 const AddTaskScreen({super.key});
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 170, 115, 229),
        centerTitle: true,
        title: const Text('Add Task'),
        titleTextStyle:const TextStyle(fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20)
          )
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 50,right: 50,top: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: TextField(
                  controller: _taskNameController,
                  decoration:const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Task Name",
                    hintStyle:  TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final taskName = _taskNameController.text.trim();
                    if (taskName.isNotEmpty) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .addTask(taskName);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  const Color.fromARGB(255, 168, 105, 234),
                    elevation: 0, // remove elevation
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: const Color.fromARGB(255, 168, 105, 234)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: const Color.fromARGB(255, 168, 105, 234),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

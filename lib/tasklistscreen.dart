// task_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todofirebase/providertask.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 170, 115, 229),
        centerTitle: true,
        title: const Text('Task List'),
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
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),             
              child: ListTile(
                title: Text(task.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: task.isCompleted,
                      onChanged: (newValue) {
                        taskProvider.toggleTaskCompletion(
                            task.id, newValue ?? false);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        taskProvider.deleteTask(task.id);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 100,
        child: FloatingActionButton(
          backgroundColor:const Color.fromARGB(255, 168, 105, 234),
          onPressed: () {
            Navigator.pushNamed(context, '/addTask');
          },
          child: const Text("Add Task",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.white,
              ),
            ),  
        ),
      ),
    );
  }
}

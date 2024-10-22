// task_provider.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todofirebase/taskmodel.dart';

class TaskProvider extends ChangeNotifier {
  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('tasks');

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final querySnapshot = await _tasksCollection.get();
    _tasks = querySnapshot.docs
        .map((doc) => Task(
              id: doc.id,
              name: doc['name'] ?? '',
              isCompleted: doc['isCompleted'] ?? false,
            ))
        .toList();
    notifyListeners();
  }

  Future<void> toggleTaskCompletion(String taskId, bool newValue) async {
    await _tasksCollection.doc(taskId).update({'isCompleted': newValue});
    await fetchTasks();
  }

  Future<void> addTask(String name) async {
    await _tasksCollection.add({'name': name, 'isCompleted': false});
    await fetchTasks();
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _tasksCollection.doc(taskId).delete();
      await fetchTasks();
    } catch (error) {
      print('Error deleting task: $error');
    }
  }
}

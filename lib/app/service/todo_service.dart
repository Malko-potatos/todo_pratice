import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_pratice/app/model/todo.dart';

Stream<List<Todo>> getTodoList(FirebaseFirestore firestore) {
  return firestore.collection('todos').snapshots().map((snapshot) {
    return snapshot.docs.map((doc) => Todo.fromDocument(doc)).toList();
  });
}

Future<void> addTodo(Todo todo, BuildContext context) async {
  try {
    Map<String, dynamic> todoJson = todo.toJson();
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('todos').add(todoJson);
    String todoId = docRef.id;
    await FirebaseFirestore.instance
        .collection('todos')
        .doc(todoId)
        .update({'id': todoId});

    Navigator.pushReplacementNamed(context, '/home');
  } catch (e) {}
}

Future<void> deleteTodoById(String id) async {
  try {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
    print('Todo deleted successfully');
  } catch (e) {
    throw Exception('Failed to delete Todo: $e');
  }
}

Future<void> updateTodoById(Todo todo, BuildContext context) async {
  FirebaseFirestore.instance
      .collection('todos')
      .doc(todo.id)
      .update(todo.toJson())
      .then((_) {
    print('Document updated successfully');
    Navigator.pushNamed(context, '/home');
  }).catchError((error) {
    print('Error updating document: $error');
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String? id;
  final String todoName;
  final String todoDesc;
  final String todoTag;
  final String todoDate;

  Todo(
      {this.id,
      required this.todoName,
      required this.todoDesc,
      required this.todoTag,
      required this.todoDate});

  Map<String, dynamic> toJson() {
    return {
      'todoName': todoName,
      'todoDesc': todoDesc,
      'todoTag': todoTag,
      'todoDate': todoDate,
    };
  }

  factory Todo.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Todo(
      id: doc.id,
      todoName: data['todoName'] ?? ' ',
      todoDesc: data['todoDesc'] ?? ' ',
      todoTag: data['todoTag'] ?? ' ',
      todoDate: data['todoDate'] ?? ' ',
    );
  }
}

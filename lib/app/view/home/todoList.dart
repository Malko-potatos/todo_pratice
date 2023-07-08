import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_pratice/app/model/todo.dart';
import 'package:todo_pratice/app/service/todo_service.dart';

import 'todoListItem.dart';

class TodoList extends StatefulWidget {
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late FirebaseFirestore firestore;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: StreamBuilder<List<Todo>>(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('불러올 데이터가 없습니다.'),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return TodoListItem(todo: snapshot.data![index]);
              },
              itemCount: snapshot.data!.length,
            );
          }
        },
        stream: getTodoList(firestore),
      ),
    );
  }
}

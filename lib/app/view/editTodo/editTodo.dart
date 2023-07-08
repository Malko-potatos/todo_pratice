import 'package:flutter/material.dart';
import 'package:todo_pratice/app/model/todo.dart';
import 'package:todo_pratice/app/service/todo_service.dart';

class EditToDo extends StatefulWidget {
  final Todo editTodo;
  const EditToDo({Key? key, required this.editTodo}) : super(key: key);

  @override
  _EditToDoState createState() => _EditToDoState();
}

class _EditToDoState extends State<EditToDo> {
  late TextEditingController taskNameController;
  late TextEditingController taskDescController;
  late String taskDate;
  late String tag;
  String date = '';
  late DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // 기존의 할일 정보를 가져와 초기값으로 설정합니다.
    taskNameController = TextEditingController(text: widget.editTodo.todoName);
    taskDescController = TextEditingController(text: widget.editTodo.todoDesc);
    tag = widget.editTodo.todoTag;
    taskDate = widget.editTodo.todoDate;
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void updateTodo() {
    // 수정된 할일 정보를 저장하는 로직을 작성합니다.
    Todo updatedTodo = Todo(
      todoName: taskNameController.text,
      todoDesc: taskDescController.text,
      todoTag: tag,
      todoDate: taskDate,
      id: widget.editTodo.id,
    );
    print('update :${updatedTodo}');

    updateTodoById(updatedTodo, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: taskNameController,
              decoration: InputDecoration(
                labelText: '제목',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: taskDescController,
              decoration: InputDecoration(
                labelText: 'Task Description',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            DropdownButtonFormField<String>(
              value: tag,
              decoration: InputDecoration(labelText: '태그'),
              onChanged: (newValue) {
                setState(() {
                  tag = newValue!;
                });
              },
              items: ['업무', '공부', '운동', '기타'].map(
                (tag) {
                  return DropdownMenuItem(value: tag, child: Text(tag));
                },
              ).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                _showDatePicker();
                date = selectedDate!.toString().substring(0, 10);
              },
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(selectedDate!.toString().substring(0, 10))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                updateTodo();
                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

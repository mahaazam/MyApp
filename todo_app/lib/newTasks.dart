import 'package:todo_app/task_model.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';

class NewTasks extends StatefulWidget {
  @override
  _NewTasksState createState() => _NewTasksState();
}

class _NewTasksState extends State<NewTasks> {
  int id;
  bool isComplete = false;
  String taskName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (value) {
                  this.taskName = value;
                },
              ),
            ),
            Checkbox(
              value: isComplete,
              onChanged: (value) {
                this.isComplete = value;
                setState(() {});
              },
            ),
            RaisedButton(
                child: Text('Add New Task'),
                onPressed: () {
                  DBHelper.dbHelper.insertNewTask(
                      Task(this.id, this.taskName, this.isComplete));
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}

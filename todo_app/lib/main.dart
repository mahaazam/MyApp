import 'package:todo_app/task_Widget.dart';
import 'package:todo_app/task_model.dart';
import 'package:flutter/material.dart';
import 'newTasks.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarPage(),
    );
  }
}

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Task> tasks;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Todo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'In Complete Tasks',
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [AllTasks(tasks), CompleteTasks(), IncompleteTasks()],
              // physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NewTasks();
            },
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  List<Task> tasks;
  AllTasks(this.tasks);

  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  deleteFun(e) {
    DBHelper.dbHelper.deleteTask(e);
    setState(() {});
  }

  Widget getAllTask(List<Task> data) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      list.add(TaskWidget(data[i], deleteFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBHelper.dbHelper.selectAllTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Task> data = snapshot.data;
            return ListView(
              children: [
                getAllTask(data),
              ],
            );
          }
        },
      ),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {});
  }

  deleteFun(i) {
    DBHelper.dbHelper.deleteTask(i);
    setState(() {});
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      list.add(TaskWidget(data[i], deleteFun, myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBHelper.dbHelper.selectSpecificTask(1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Task> data = snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}

class IncompleteTasks extends StatefulWidget {
  @override
  _IncompleteTasksState createState() => _IncompleteTasksState();
}

class _IncompleteTasksState extends State<IncompleteTasks> {
  myFun() {
    setState(() {});
  }

  deleteFun(i) {
    DBHelper.dbHelper.deleteTask(i);
    setState(() {});
  }

  Widget getTaskWidgets(List<Task> data) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      list.add(TaskWidget(data[i], deleteFun, myFun));
    }
    return new Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: FutureBuilder<List<Task>>(
        future: DBHelper.dbHelper.selectSpecificTask(0),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Task> data = snapshot.data;
            return ListView(
              children: [
                getTaskWidgets(data),
              ],
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/task.dart';

class Homepage extends StatefulWidget {
  Homepage();

  @override
  State<StatefulWidget> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> {
  String? _newtaskcontent;
  Box? _box;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create & Delete Tasks!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: _taskview(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Widget _listview() {
    if (_box == null) {
      return Center(child: CircularProgressIndicator());
    }

    List tasks = _box!.values.toList();

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(Map<String, dynamic>.from(tasks[_index]));
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              decoration: task.done ? TextDecoration.lineThrough  : null , 
            ),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.done ? Icons.check_box_outlined : Icons.check_box_outline_blank,
            color: Colors.pinkAccent,
          ),

          onTap: (){
               setState(() {
                  task.done = !task.done;
                _box!.putAt(_index, task.toMap());
               });
          },
          onLongPress: (){
            setState(() {
              _box!.deleteAt(_index);
            });
          },
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      onPressed: _onpressed,
      backgroundColor: Colors.purple,
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  void _onpressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New Task"),
          content: TextField(
            decoration: InputDecoration(hintText: "Enter task here"),
            onSubmitted: (_value) {
              setState(() {
                _newtaskcontent = _value; 
                if (_newtaskcontent != null) {
                  var _task = Task(
                    content: _newtaskcontent!,
                    done: false,
                    timestamp: DateTime.now(),
                  );
                  _box!.add(_task.toMap()); 
                }
              });
              Navigator.of(context).pop(); 
            },
            onChanged: (_value) {
              setState(() {
                _newtaskcontent = _value; 
              });
            },
          ),
          
        );
      },
    );
  }

  Widget _taskview() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data;
          return _listview();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
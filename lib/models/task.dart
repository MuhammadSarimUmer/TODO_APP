import 'package:flutter/foundation.dart';

class Task {
String content;
bool done;
DateTime timestamp;

Task({required this.content, required this.done, required this.timestamp});


factory Task.fromMap(Map task){

  return Task(content: task['content'], done: task['done'], timestamp: task['timestamp']);
}


Map toMap() {
  return{
    "content": content,
    "done": done,
    "timestamp": timestamp,
  };
}
}
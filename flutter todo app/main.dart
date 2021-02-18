import 'package:flutter/material.dart';
// import 'package:todo_app/util/dbhelper.dart';
// import 'package:todo_app/model/todo.dart';
import 'package:todo_app/screens/todolist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    // List<Todo> todos = List<Todo>();
    // DbHelper helper = DbHelper();
    // helper.initializeDb().then(
    //   (result) => helper.getTodos().then((result)=>todos=result));
    // DateTime today = DateTime.now();
    // //helper.deleteAll();
    // Todo todo = Todo("fill up gas", 3, today.toString(), "and make sure they good");   
    // var result = helper.insertTodo(todo);
    
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'My To-Do List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  

  @override
  Widget build(BuildContext context) {
   return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: TodoList(),
    );
  }
}

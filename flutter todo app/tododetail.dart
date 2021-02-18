import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/util/dbhelper.dart';
import 'package:intl/intl.dart';

DbHelper helper = DbHelper();

final List<String> choices = const <String> ['Save To-Do & Back', 'Delete To-Do', 'Back to List'];
const mnuSave = 'Save To-Do & Back';
const mnuDelete = 'Delete To-Do';
const mnuBack = 'Back to List';

class TodoDetail extends StatefulWidget {
  final Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() => TodoDetailState(todo);
  
}

class TodoDetailState extends State {
  Todo todo;
  TodoDetailState(this.todo);
  final _priorities = ["Priority: High", "Priority: Medium", "Priority: Low"];
  String _priority = "Low";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = todo.title;
    descriptionController.text = todo.description;
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        title: todo.title == "" ? Text("Add New To-Do") : Text(todo.title), 
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context){
              return choices.map((String choice) {
                return PopupMenuItem<String>(value: choice, child: Text(choice));
              }).toList();
            },
          )
        ]
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0), 
        child: ListView(
          children: <Widget>[
            Column(children: <Widget>[

            // Title Textbox
              TextField(
                controller: titleController,
                style: textStyle,
                onChanged: (value) => this.updateTitle(),
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textStyle,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                ),
              ),

            // Description Textbox
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0), 
                child: TextField(
                  controller: descriptionController,
                  style: textStyle,
                  onChanged: (value) => this.updateDescription(),
                  decoration: InputDecoration(
                    labelText: "Descrption",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                  ),
                )
              ),

            // Priority Dropdown menu
              ListTile(title: DropdownButton<String>(
                items: _priorities.map((String value) {
                  return DropdownMenuItem<String> (value: value, child: Text(value));
                }).toList(),
                style: textStyle,
                value: retrievePriority(todo.priority),
                onChanged: (value) => updatePriority(value),
              )),

          //   // Save Button
          //   Row(children: <Widget>[
          //     Expanded(
          //       child: RaisedButton(
          //         color: Theme.of(context).primaryColorDark,
          //         textColor: Colors.white,
          //         onPressed: () {
          //           setState(() {
          //             save();
          //           });
          //         },
          //         child: Text("Save", textScaleFactor: 1.5),
          //       )
          //     ),

          //  // Delete Button
          //     Expanded(
          //       child: RaisedButton(
          //         color: Colors.red,
          //         textColor: Colors.white,
          //         onPressed: () {
          //           setState(() {
          //             delete();
          //           });
          //         },
          //         child: Text("Delete", textScaleFactor: 1.5)
          //       )
          //     )
          //   ],)

            ],)
          ]
        )
      )
    );
  }

  void select(String value) async {
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        int result;
        Navigator.pop(context, true);
        if (todo.id == null){
          return;
        } 
        result = await helper.deleteTodo(todo.id);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(title: Text("Successful!"), content: Text("The To-Do has been deleted."));
          showDialog(context: context, builder: (_) => alertDialog);
        }
        break;
      case mnuBack:
        // if (titleController.text == ""){
        //   AlertDialog alertDialog = AlertDialog(title: Text("Error!"), content: Text("Title cannot be empty."));
        //   showDialog(context: context, builder: (_) => alertDialog);
        // }
        // else{
          Navigator.pop(context, true);
        // }
        break;
    }
  }

  void save() {
    todo.date = new DateFormat.yMd().format(DateTime.now());
    if (todo.id != null) {
      helper.updateTodo(todo);
    }
    else {
      helper.insertTodo(todo);
    }
    // if (titleController.text == ""){
    //   AlertDialog alertDialog = AlertDialog(title: Text("Error!"), content: Text("Title cannot be empty."));
    //     showDialog(context: context, builder: (_) => alertDialog);
    // }
    // else{
      Navigator.pop(context, true);
    // }
    
  }

  // void delete() async {

  // }

  void updatePriority(String value) {
    switch (value) {
      case "Priority: High":
        todo.priority = 1;
        break;
      case "Priority: Medium":
        todo.priority = 2;
        break;
      case "Priority: Low":
        todo.priority = 3;
        break;
    }

    setState(() {
      _priority = value;
    });
  }

  String retrievePriority(int value) {
    return _priorities[value-1];
  }

  void updateTitle(){
    todo.title = titleController.text;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }
}
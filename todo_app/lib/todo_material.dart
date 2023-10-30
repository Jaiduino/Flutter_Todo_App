import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/Entitys/todo.dart';
import 'package:todo_app/widgets/todo_item.dart';

// ignore: camel_case_types
class todo_app_stateless extends StatefulWidget {
  // final Todo todo;
  const todo_app_stateless({super.key});

  @override
  State<todo_app_stateless> createState() => _todo_app_statelessState();
}

// ignore: camel_case_types
class _todo_app_statelessState extends State<todo_app_stateless> {
  final todosList = Todo.todoList();
  List<Todo> _foundToDo = [];
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.grey[700],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              size: 35,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/avtar.jpg'),
              ),
            )
          ],
        ));
  }

  // ignore: non_constant_identifier_names
  Widget _SearchBox() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 3),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
                size: 25,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, maxWidth: 25),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(234, 255, 255, 255),
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                children: [
                  _SearchBox(),
                  Expanded(
                      child: ListView(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      child: const Text(
                        "All ToDo's",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (Todo todoo in _foundToDo.reversed)
                      TodoItem(
                        todo: todoo,
                        onTodoChanged: _handelToDoChange,
                        onDeleteItem: _onDeleteItem,
                      )
                  ]))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.brown,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                          hintText: "Add New Todo item",
                          border: InputBorder.none),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        print("add is pressd");
                        if (_todoController.text == "") {
                          print("Null");
                          _showToast("Enter ToDo");
                        } else {
                          print(_todoController.text);
                          _addTodoItem(_todoController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[850],
                          minimumSize: Size(60, 60),
                          elevation: 10),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void _handelToDoChange(Todo todo) {
    setState(() {
      if (todo.isDone == true) {
        todo.isDone = false;
      } else if (todo.isDone == false) {
        todo.isDone = true;
      }
    });
  }

  void _onDeleteItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todoText) {
    print("inside addTodo");
    print(todoText);
    if (todoText != null) {
      setState(() {
        todosList.add(Todo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            todoText: todoText,
            isDone: false));
      });
    } else {
      print("todo is null");
    }

    _todoController.clear();
  }

  void _runFilter(String keyword) {
    List<Todo> res = [];
    if (keyword.isEmpty) {
      res = todosList;
    } else {
      res = todosList
          .where((item) =>
              item.todoText!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = res;
    });
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message, //message to show toast
        toastLength: Toast.LENGTH_LONG, //duration for message to show
        gravity: ToastGravity.CENTER, //where you want to show, top, bottom
        timeInSecForIosWeb: 1, //for iOS only
        //backgroundColor: Colors.red, //background Color for message
        textColor: Colors.white, //message text color
        fontSize: 20.0 //message font size
        );
  }
}

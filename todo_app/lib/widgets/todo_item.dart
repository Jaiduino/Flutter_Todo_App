import 'package:flutter/material.dart';
import 'package:todo_app/Entitys/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final onTodoChanged;
  final onDeleteItem;
  const TodoItem(
      {super.key, required this.todo, this.onTodoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: ListTile(
        onTap: () {
          print("object");
          onTodoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.black12,
        leading: Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
          color: const Color.fromARGB(255, 30, 33, 230),
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 1),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.delete),
            iconSize: 18,
            onPressed: () {
              onDeleteItem(todo.id);
              print("Delete");
            },
          ),
        ),
      ),
    );
  }
}

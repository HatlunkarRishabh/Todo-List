// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo_lisr/constants/colors.dart';
import '../models/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap:() {
          // print('clicked on todo');
          onToDoChanged(todo);
        },

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Color.fromARGB(26, 148, 147, 147),
        leading: Icon(
          todo.isDone? Icons.check_box: Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          todo.todotext!,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black, 
            decoration: todo.isDone? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
        padding: EdgeInsets.all(0),
        margin: EdgeInsets.symmetric(vertical: 12),
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: tdRed,
          borderRadius: BorderRadius.circular(5)
        ),
        child: IconButton(
          color: tgWhite,
          onPressed: () {
            // print('clicked on detele');
            onDeleteItem(todo.id);
          },
          iconSize: 18,
          icon: Icon(Icons.delete),
        ),
      ),
      ),
    );
  }
}
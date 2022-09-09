// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todo/constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onChange;
  final onDelete;
  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onChange,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
            onTap: () {
              onChange(todo);
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            tileColor: cWhite,
            leading: IconButton(
              onPressed: () {
                onChange(todo);
              },
              icon: Icon(
                todo.isDone!
                    ? Icons.check_circle_outline
                    : Icons.circle_outlined,
                color: cBlue,
              ),
            ),
            title: Text(
              todo.todo!,
              style: TextStyle(
                  fontSize: 16,
                  color: cBlack,
                  decoration: todo.isDone!
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            trailing: IconButton(
              onPressed: () {
                onDelete(todo.id!);
              },
              icon: const Icon(
                Icons.delete_outline,
                color: cRed,
              ),
            )),
      ),
    );
  }
}

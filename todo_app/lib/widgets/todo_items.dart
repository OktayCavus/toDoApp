import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:todo_app/constant/constant.dart';
import 'package:todo_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
    // !!!!!!!buraya dikkat
    final ToDo todo;
    final onToDoChanged;
    final onDeleteItem;
    const ToDoItem({super.key , required this.todo, this.onToDoChanged, this.onDeleteItem});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(

        onTap: (){
          onToDoChanged(todo);
        },
        contentPadding: [20,5].horizontalAndVerticalP,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20) ),
        tileColor: Colors.white,
        leading:  Icon(
          todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank_outlined ,color:tdBlue),
        title:  Text(todo.todoText!,
        style:  TextStyle(
          fontSize: 16,
          color: tdBlack,
          decoration: todo.isDone! ? TextDecoration.lineThrough : null ),),
          trailing: Container(
            padding: 0.allP,
            margin: 12.verticalP,
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5)
            ),
            child: IconButton(
              iconSize: 18,
              color: Colors.white,
              icon: const Icon(Icons.delete),
              onPressed: (){
                onDeleteItem(todo.id);
              },
              ),
          ),
      ),
    );
  }
}
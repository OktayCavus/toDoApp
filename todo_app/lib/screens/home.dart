import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:todo_app/constant/constant.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/todo_items.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todosList = ToDo.todoList();
  final _todoController = TextEditingController();
  List <ToDo> _foundToDo= [];

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: [20,15].horizontalAndVerticalP,
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50 , bottom: 20),
                        child: const Text('All ToDos' , style:TextStyle(fontSize: 30, fontWeight: FontWeight.w500),),
                      ),
                      
                      //for(ToDo todoo in todosList) // ! bu filtreleme yapmadan önceydi
                      // ! reverse olmasının sebebi eklenen itemin en başa gelmesi
                      for(ToDo todoo in _foundToDo.reversed)
                      ToDoItem(todo:todoo ,
                      onToDoChanged: _handleToDoChange,
                      onDeleteItem: _deleteToDoItem,)

                    ],
                  ),
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(child:
              Container(
                margin: const EdgeInsets.only(bottom: 20,right: 20,left: 20),
                padding: [20,5].horizontalAndVerticalP,
                decoration:   BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0,0.0),
                    blurRadius: 10,
                    spreadRadius: 0)],
                    borderRadius: BorderRadius.circular(10)
                    ),

                    child:  TextField(
                      controller: _todoController,
                      decoration: const InputDecoration(
                        hintText: 'Add a new todo item',
                        border: InputBorder.none
                      ),
                    ),
              ),),

              Container(
                margin:  const EdgeInsets.only(bottom: 20,right: 20),
                child: ElevatedButton(onPressed: (){
                  _addToDoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: tdBlue,minimumSize: const Size(60,60)) ,child:const Text('+' , style: TextStyle(fontSize: 40),),
                ),
              )
            ]),
            )
        ],
      ),
    );
  }


  void _runFilter(String enteredKeyword){
    List <ToDo> results = [];
    // !!!!! girilen kelime yoksa bütün listeyi döndürüyor varsa 
    if(enteredKeyword.isEmpty){
      results = todosList;
    }
    else {
      results = todosList
      .where((item) => item
      .todoText!
      .toLowerCase()
      .contains(enteredKeyword.toLowerCase()))
      .toList();
    }

  setState(() {
    _foundToDo = results;
  });
  }

// !!!!!!!!!!! TİK'İ KONTROL EDİYOR
  void _handleToDoChange(ToDo todo){
    setState(() {
        todo.isDone = !todo.isDone!;
    });
  }


  void _deleteToDoItem(String id){
    setState(() {
    todosList.removeWhere((item) => item.id == id);
    });

  }

  void _addToDoItem(String toDoText){
    setState(() {
      todosList.add(ToDo(id: DateTime.now().microsecondsSinceEpoch.toString(),
      todoText: toDoText));
    });
    _todoController.clear();

  }



Widget searchBox(){
  return Container(
              padding: 15.horizontalP,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
              ),
              child:  TextField(
                // ! filtrelemeyi düzgün yapmak için koyuldu
                onChanged:(value) => _runFilter(value),

                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
                  prefixIcon: Icon(Icons.search_outlined,color: tdBlack,),
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(color: tdGrey)
                ),
              ),
              );
}

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      leading: const Icon(Icons.menu , color: tdBlack,),
      actions: [
        Padding(
          padding: 10.onlyRightP,
          child: SizedBox(
            height: 35,
            width: 35,
            child:ClipRRect(
              child: Image.asset(getName('avatar'),),
          )),
        )
        ],
    );
  }
}


// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../constants/colors.dart';
import '../widget/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();
  

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tgWhite,
      appBar: _buildAppBar(),

      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20, 
              vertical: 15
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      TextTitle(),
                      todosList.isEmpty
                          ? Center(
                              child: Text(
                                'No Remaining Task present',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : Column(
                              children: [
                                for (ToDo todoo in _foundToDo.reversed)
                                  ToDoItem(
                                    todo: todoo,
                                    onToDoChanged: _handleToDoChange,
                                    onDeleteItem: _deleteToDoItem,
                                  ),
                              ],
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0,0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      )],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add a new To Do item',
                        border: InputBorder.none
                      )
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(60, 60),
                      elevation: 10,
                    ),
                    child: const Text('+',style: TextStyle(fontSize: 40, color: Colors.white),),
                  ),
                )
              ],
            )
          ) 
        ] 
      ), 
  );
}


//=============================================================Containers=========================================================
  Container TextTitle() {
    return Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: const Text(
                        "To Do's",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    );
  }

    Container searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 185, 185, 185),
        borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        onChanged: (value) => _runfilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tgWhite,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tgWhite)
        ),
      ),
    );
  }

// ================================================================================================================================


//===================================================functions of functionality======================================================
  void _handleToDoChange(ToDo todo){
    setState(() {  
      todo.isDone  = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo){
    setState(() { 
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), 
          todotext: toDo
        )
      );
    });
    _todoController.clear();
  }

  void _runfilter(String enteredKeyword){
    List<ToDo> results = [];
    if(enteredKeyword.isEmpty ){
      results = todosList;
    } else{
      results = todosList
        .where((item) => item.todotext!
          .toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
        .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  // ================================================================================================================================


// =====================================================App Bar======================================================================
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tgWhite,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu, 
            color: tgBlack,
            size: 30,
          ),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              child: Image.asset('assets/images/avatar.png'),
            ),
          )
        ],
      ),
    );
  }

// =================================================================================================================================

}

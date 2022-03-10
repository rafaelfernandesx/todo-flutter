import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_app_mobx/components/TodoItem.dart';
import 'package:todo_app_mobx/models/todo.model.dart';
import 'package:todo_app_mobx/stores/todo.store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Colors.grey,
            selectionHandleColor: Colors.grey,
          )),
      home: MyHomePage(),
    );
  }
}

final todoStore = TodoStore();

class MyHomePage extends StatelessWidget {
  final TextEditingController _todo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Observer(
              builder: (_) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(todoStore.todos.length.toString()),
              ),
            ),
            Expanded(
              child: TextField(
                controller: _todo,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  hintText: 'Type your todo',
                  hintStyle: TextStyle(color: Color(0xFFCFCFCF)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: Observer(
          builder: (_) => ListView.builder(
            itemCount: todoStore.todos.length,
            itemBuilder: (context, index) {
              var todo = todoStore.todos[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  todoStore.remove(todo);

                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${todo.title} dismissed'),
                    ),
                  );
                },
                child: TodoItem(title: todo.title, done: todo.done),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_todo.value.text.isNotEmpty) {
            var todo = Todo(_todo.value.text, false);
            todoStore.add(todo);
            _todo.clear();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Type some todo"),
            ));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

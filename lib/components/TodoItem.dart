import 'dart:math';

import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final bool done;

  const TodoItem({
    Key? key,
    required this.title,
    required this.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.all(10),
      color: const Color(0xFF525353),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Icon(
              Icons.check,
              color: done ? Colors.green : Colors.white,
            ),
            style: OutlinedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(10),
              side: BorderSide(
                width: 2,
                color: done ? Colors.green : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
